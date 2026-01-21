
# MySQL 8 Tar Install on Fedora (SELinux) – Reference Guide

> **Purpose**: This document captures the **important, non-obvious steps** and **root-cause fixes** used to successfully install **MySQL 8.x (tar distribution)** on **Fedora with SELinux enforcing**.
>
> Use this as a **future reference** to avoid repeating the same issues.

---

## 1. Final Working Architecture (IMPORTANT)

| Component         | Value                               |
| ----------------- | ----------------------------------- |
| MySQL install dir | `/opt/mysql`                        |
| Config file       | `/etc/my.cnf`                       |
| Data directory    | `/var/lib/mysql`                    |
| Log directory     | `/var/log/mysql`                    |
| Runtime dir       | `/run/mysqld`                       |
| Socket            | `/run/mysqld/mysql.sock`            |
| systemd service   | `/etc/systemd/system/mysql.service` |
| SELinux           | **Enforcing**                       |

> ❌ Do **not** use `/tmp/mysql.sock` on SELinux systems

---

## 2. Why Tar Install on Fedora Is Hard

Fedora + SELinux assumes **RPM-based MySQL**. When using a **tar distribution**:

* No SELinux policy is installed
* No file contexts exist
* systemd runs in a **restricted environment**
* MySQL private libraries live in **non-standard paths**

Result:

* `status=203/EXEC`
* `status=127`
* endless `AVC denied` errors

This guide solves **only the necessary parts**, not everything.

---

## 3. systemd Service (FINAL & WORKING)

**File**: `/etc/systemd/system/mysql.service`

```ini
[Unit]
Description=Custom MySQL Server
After=network.target
Wants=network-online.target

[Service]
Type=simple
User=mysql
Group=mysql

WorkingDirectory=/opt/mysql
Environment="LD_LIBRARY_PATH=/opt/mysql/lib:/opt/mysql/lib/private"

ExecStart=/opt/mysql/bin/mysqld --defaults-file=/etc/my.cnf
ExecStop=/bin/kill -s TERM $MAINPID
Restart=always
TimeoutSec=300

[Install]
WantedBy=multi-user.target
```

**Why this matters**:

* `LD_LIBRARY_PATH` is **required** for tar installs
* systemd does **not inherit shell env**

---

## 4. MySQL Config (FINAL & SAFE)

**File**: `/etc/my.cnf`

```ini
[mysqld]
basedir=/opt/mysql
datadir=/var/lib/mysql

pid-file=/run/mysqld/mysqld.pid
socket=/run/mysqld/mysql.sock
mysqlx_socket=/run/mysqld/mysqlx.sock

port=3306
user=mysql
log-error=/var/log/mysql/mysql.log

character-set-server=utf8mb4
collation-server=utf8mb4_unicode_ci

[client]
socket=/run/mysqld/mysql.sock
```

---

## 5. SELinux – The REAL Fixes (MOST IMPORTANT SECTION)

### 5.1 Install MySQL SELinux Policy

```bash
sudo dnf install -y mysql-server policycoreutils-python-utils
```

> This installs **SELinux types only**. The RPM mysqld binary is **not used**.

---

### 5.2 Label mysqld Binary (EXEC FIX)

```bash
sudo semanage fcontext -a -t mysqld_exec_t "/opt/mysql/bin/mysqld"
sudo restorecon -v /opt/mysql/bin/mysqld
```

Without this → `status=203/EXEC`

---

### 5.3 Label MySQL Libraries (READ + EXEC FIX)

```bash
sudo semanage fcontext -a -t mysqld_exec_t "/opt/mysql/lib/private(/.*)?\.so(\..*)?"
sudo semanage fcontext -a -t mysqld_exec_t "/opt/mysql/lib/plugin(/.*)?\.so(\..*)?"

sudo restorecon -Rv /opt/mysql/lib/private /opt/mysql/lib/plugin
```

Fixes:

* `libcrypto.so.3` denied
* `libssl.so.3` denied
* plugin `.so` execution denied

---

### 5.4 Label MySQL Share Files (READ FIX)

```bash
sudo semanage fcontext -a -t mysqld_db_t "/opt/mysql/share(/.*)?"
sudo restorecon -Rv /opt/mysql/share
```

Fixes:

* `errmsg.sys` denied
* `Index.xml` denied

---

### 5.5 Runtime Directory (SOCKET FIX)

```bash
sudo mkdir -p /run/mysqld
sudo chown mysql:mysql /run/mysqld

sudo semanage fcontext -a -t mysqld_var_run_t "/run/mysqld(/.*)?"
sudo restorecon -Rv /run/mysqld
```

**Why**:

* `mysqld_t` cannot create sockets in `tmp_t`
* `/run/mysqld` is SELinux-approved

---

## 6. Data Directory Initialization (ONE TIME ONLY)

```bash
sudo -u mysql /opt/mysql/bin/mysqld \
  --defaults-file=/etc/my.cnf \
  --initialize
```

> ⚠️ Never run `--initialize` again

---

## 7. Common Errors & Their Meaning

| Error                | Real Cause                   | Fix                        |
| -------------------- | ---------------------------- | -------------------------- |
| `status=203/EXEC`    | SELinux blocked execution    | `mysqld_exec_t`            |
| `status=127`         | Loader/lib/SELinux           | `LD_LIBRARY_PATH` + labels |
| No socket            | SELinux denied socket create | `/run/mysqld`              |
| TCP handshake lost   | MySQL crashed during startup | Check AVC logs             |
| `user_home_t` denial | Wrong file labels            | relabel paths              |

---

## 8. Debug Commands (SAVE THESE)

```bash
# systemd
systemctl status mysql
journalctl -xeu mysql

# SELinux
ausearch -m AVC,USER_AVC -ts recent
ls -Z <path>

# MySQL
SHOW VARIABLES LIKE 'socket';
SHOW VARIABLES LIKE 'datadir';
```

---

## 9. Post-Install Checklist

* [ ] Change root password
* [ ] Create app user (do not use root)
* [ ] Enable service at boot
* [ ] Backup `/etc/my.cnf`
* [ ] Backup SELinux fcontext rules

---

## 10. Final Notes (READ THIS)

* This setup is **production-safe**
* SELinux is **fully enforcing**
* No hacks like `setenforce 0`
* No insecure `/tmp` sockets

> If this breaks in future, **check SELinux first**.

---

**Author note**: This setup resolved **all Fedora + SELinux + tar-install edge cases**. Save this file.
