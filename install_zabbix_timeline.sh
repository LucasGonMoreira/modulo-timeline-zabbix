#!/bin/bash
# Zabbix Timeline Module Installer

echo "=========================================="
echo "  Instalador do MÃ³dulo Timeline - Zabbix"
echo "=========================================="
echo ""

# Find Zabbix UI Directory
ZABBIX_UI_DIR=""
POSSIBLE_DIRS=(
    "/usr/share/zabbix/ui"
    "/usr/share/zabbix"
    "/var/www/html/zabbix"
    "/var/www/zabbix"
    "/usr/share/nginx/html/zabbix"
)

for dir in "${POSSIBLE_DIRS[@]}"; do
    if [ -d "$dir/modules" ]; then
        ZABBIX_UI_DIR="$dir"
        break
    fi
done

if [ -z "$ZABBIX_UI_DIR" ]; then
    echo "NÃ£o foi possÃ­vel detectar automaticamente o diretÃ³rio do Zabbix UI."
    read -p "Digite o caminho absoluto do Zabbix (ex: /usr/share/zabbix): " ZABBIX_UI_DIR
    if [ ! -d "$ZABBIX_UI_DIR/modules" ]; then
        echo "Erro: O diretÃ³rio '$ZABBIX_UI_DIR/modules' nÃ£o existe."
        exit 1
    fi
fi

echo "DiretÃ³rio do Zabbix encontrado/definido em: $ZABBIX_UI_DIR"
MODULES_DIR="$ZABBIX_UI_DIR/modules"

# Decode and extract module payload
echo "Extraindo arquivos do mÃ³dulo..."
PAYLOAD=$(cat << 'EOF'
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
EOF
)

echo "$PAYLOAD" | base64 -d | tar -xz -C "$MODULES_DIR"

if [ $? -eq 0 ]; then
    echo "Arquivos copiados com sucesso para $MODULES_DIR/timeline."
else
    echo "Erro ao extrair os arquivos."
    exit 1
fi

# Set permissions
chown -R www-data:www-data "$MODULES_DIR/timeline" 2>/dev/null || chown -R apache:apache "$MODULES_DIR/timeline" 2>/dev/null || chown -R nginx:nginx "$MODULES_DIR/timeline" 2>/dev/null
chmod -R 755 "$MODULES_DIR/timeline"

echo ""
echo "=========================================="
echo " ConfiguraÃ§Ã£o do Banco de Dados"
echo "=========================================="
echo "Precisamos criar a tabela 'zbx_incident_timeline' no banco de dados do Zabbix."

read -p "Deseja configurar o banco de dados automaticamente agora? (s/n): " RUN_DB
if [[ "$RUN_DB" == "s" || "$RUN_DB" == "S" ]]; then
    echo "1) MySQL / MariaDB"
    echo "2) PostgreSQL"
    read -p "Qual Ã© o seu banco de dados? (1 ou 2): " DB_TYPE

    read -p "Host do banco de dados (ex: localhost): " DB_HOST
    DB_HOST=${DB_HOST:-localhost}
    read -p "Nome do banco de dados (ex: zabbix): " DB_NAME
    DB_NAME=${DB_NAME:-zabbix}
    read -p "UsuÃ¡rio do banco de dados (ex: zabbix ou root): " DB_USER
    DB_USER=${DB_USER:-zabbix}
    read -p "Senha do banco de dados (deixe em branco se nÃ£o houver): " DB_PASS

    if [ "$DB_TYPE" = "1" ]; then
        SQL_QUERY="CREATE TABLE IF NOT EXISTS zbx_incident_timeline (
            timelineid BIGINT UNSIGNED NOT NULL,
            title VARCHAR(255) DEFAULT '' NOT NULL,
            description TEXT NOT NULL,
            incident_time BIGINT UNSIGNED NOT NULL,
            end_time BIGINT UNSIGNED DEFAULT 0 NOT NULL,
            status INT DEFAULT 0 NOT NULL,
            responsible VARCHAR(255) DEFAULT '' NOT NULL,
            PRIMARY KEY (timelineid)
        );"
        MYSQL_CMD="mysql -u \"$DB_USER\" -h \"$DB_HOST\""
        if [ -n "$DB_PASS" ]; then
            MYSQL_CMD="$MYSQL_CMD -p\"$DB_PASS\""
        fi
        MYSQL_CMD="$MYSQL_CMD \"$DB_NAME\""
        
        echo "Executando script SQL no MySQL/MariaDB..."
        eval "$MYSQL_CMD -e \"\$SQL_QUERY\""
        
        if [ $? -eq 0 ]; then
            echo "Tabela criada com sucesso!"
        else
            echo "Aviso: Houve um erro ao criar a tabela no MySQL."
        fi
    elif [ "$DB_TYPE" = "2" ]; then
        SQL_QUERY="CREATE TABLE IF NOT EXISTS zbx_incident_timeline (
            timelineid BIGINT NOT NULL,
            title VARCHAR(255) DEFAULT '' NOT NULL,
            description TEXT NOT NULL,
            incident_time BIGINT NOT NULL,
            end_time BIGINT DEFAULT 0 NOT NULL,
            status INT DEFAULT 0 NOT NULL,
            responsible VARCHAR(255) DEFAULT '' NOT NULL,
            PRIMARY KEY (timelineid)
        );"
        export PGPASSWORD="$DB_PASS"
        echo "Executando script SQL no PostgreSQL..."
        psql -U "$DB_USER" -h "$DB_HOST" -d "$DB_NAME" -c "$SQL_QUERY"
        
        if [ $? -eq 0 ]; then
            echo "Tabela criada com sucesso!"
        else
            echo "Aviso: Houve um erro ao criar a tabela no PostgreSQL."
        fi
    else
        echo "OpÃ§Ã£o invÃ¡lida."
    fi
else
    echo "VocÃª optou por nÃ£o criar a tabela automaticamente."
    echo "Por favor, rode o seguinte comando no seu banco de dados MySQL:"
    echo "CREATE TABLE IF NOT EXISTS zbx_incident_timeline ( timelineid BIGINT UNSIGNED NOT NULL, title VARCHAR(255) DEFAULT '' NOT NULL, description TEXT NOT NULL, incident_time BIGINT UNSIGNED NOT NULL, end_time BIGINT UNSIGNED DEFAULT 0 NOT NULL, status INT DEFAULT 0 NOT NULL, responsible VARCHAR(255) DEFAULT '' NOT NULL, PRIMARY KEY (timelineid) );"
    echo ""
    echo "Ou se for PostgreSQL:"
    echo "CREATE TABLE IF NOT EXISTS zbx_incident_timeline ( timelineid BIGINT NOT NULL, title VARCHAR(255) DEFAULT '' NOT NULL, description TEXT NOT NULL, incident_time BIGINT NOT NULL, end_time BIGINT DEFAULT 0 NOT NULL, status INT DEFAULT 0 NOT NULL, responsible VARCHAR(255) DEFAULT '' NOT NULL, PRIMARY KEY (timelineid) );"
fi

echo ""
echo "=========================================="
echo " InstalaÃ§Ã£o ConcluÃ­da!"
echo "=========================================="
echo "Para ativar o mÃ³dulo no Zabbix:"
echo "1. Acesse o Zabbix via navegador."
echo "2. VÃ¡ em AdministraÃ§Ã£o -> Geral -> MÃ³dulos (ou AdministraÃ§Ã£o -> MÃ³dulos)."
echo "3. Clique em 'Scan directory' (Escanear diretÃ³rio)."
echo "4. O mÃ³dulo 'Timeline' aparecerÃ¡. Clique em 'Enable' (Ativar)."
echo "5. O menu 'Timeline' surgirÃ¡ na aba Monitoring."
