# Apache

Local Webserver for HTTP and PHP

[http://localhost](http://localhost)

##### /etc/apache2/httpd.conf

```bash
### Uncomment modules loading
LoadModule proxy_module libexec/apache2/mod_proxy.so
LoadModule proxy_http_module libexec/apache2/mod_proxy_http.so
LoadModule rewrite_module libexec/apache2/mod_rewrite.so
LoadModule php7_module libexec/apache2/libphp7.so

### Setup DocumentRoot
DocumentRoot "~/Workspace"
<Directory "~/Workspace">
    Options Indexes FollowSymLinks Multiviews
    MultiviewsMatch Any
    AllowOverride All
    Require all granted
</Directory>

### Append to the bottom of the file and save
Include <vhost_path>/vhosts/*.conf
```

##### <vhost_path>/vhosts/000-default.conf

```bash
<VirtualHost *:80>
	DocumentRoot "~/Workspace" # Default has the same DocumentRoot of httpd.conf
</VirtualHost>
```

##### <vhost_path>/vhosts/template.info.conf

```bash
<VirtualHost *:80>
    SetEnv APPLICATION_ENV development  # Zend Framework env

    ServerName template.info              # Main domain
    ServerAlias www.template.info         # Alias
    ServerAlias admin.template.info       # Alias
    # ServerAlias ...

    DocumentRoot "/project/path"        # DocumentRoot path
    <Directory "/project/path">         # DocumentRoot directory configuration
        # Options...
    </Directory>
</VirtualHost>
```

##### Commands

```bash
sudo apachectl start    # Start webserver
sudo apachectl stop     # Stop webserver
sudo apachectl restart  # Restart webserver
sudo apachectl reload   # Reload Configuration
apachectl configtest    # Test Configuration
```
