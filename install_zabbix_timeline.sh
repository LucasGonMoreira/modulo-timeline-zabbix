#!/bin/bash
# Zabbix Timeline Module Installer

echo "=========================================="
echo "  Instalador do Módulo Timeline - Zabbix"
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
    echo "Não foi possível detectar automaticamente o diretório do Zabbix UI."
    read -p "Digite o caminho absoluto do Zabbix (ex: /usr/share/zabbix): " ZABBIX_UI_DIR
    if [ ! -d "$ZABBIX_UI_DIR/modules" ]; then
        echo "Erro: O diretório '$ZABBIX_UI_DIR/modules' não existe."
        exit 1
    fi
fi

echo "Diretório do Zabbix encontrado/definido em: $ZABBIX_UI_DIR"
MODULES_DIR="$ZABBIX_UI_DIR/modules"

# Decode and extract module payload
echo "Extraindo arquivos do módulo..."
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
echo " Configuração do Banco de Dados"
echo "=========================================="
echo "Precisamos criar a tabela 'zbx_incident_timeline' no banco de dados do Zabbix."

read -p "Deseja configurar o banco de dados automaticamente agora? (s/n): " RUN_DB
if [[ "$RUN_DB" == "s" || "$RUN_DB" == "S" ]]; then
    echo "1) MySQL / MariaDB"
    echo "2) PostgreSQL"
    read -p "Qual é o seu banco de dados? (1 ou 2): " DB_TYPE

    read -p "Host do banco de dados (ex: localhost): " DB_HOST
    DB_HOST=${DB_HOST:-localhost}
    read -p "Nome do banco de dados (ex: zabbix): " DB_NAME
    DB_NAME=${DB_NAME:-zabbix}
    read -p "Usuário do banco de dados (ex: zabbix ou root): " DB_USER
    DB_USER=${DB_USER:-zabbix}
    read -p "Senha do banco de dados (deixe em branco se não houver): " DB_PASS

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
        echo "Opção inválida."
    fi
else
    echo "Você optou por não criar a tabela automaticamente."
    echo "Por favor, rode o seguinte comando no seu banco de dados MySQL:"
    echo "CREATE TABLE IF NOT EXISTS zbx_incident_timeline ( timelineid BIGINT UNSIGNED NOT NULL, title VARCHAR(255) DEFAULT '' NOT NULL, description TEXT NOT NULL, incident_time BIGINT UNSIGNED NOT NULL, end_time BIGINT UNSIGNED DEFAULT 0 NOT NULL, status INT DEFAULT 0 NOT NULL, responsible VARCHAR(255) DEFAULT '' NOT NULL, PRIMARY KEY (timelineid) );"
    echo ""
    echo "Ou se for PostgreSQL:"
    echo "CREATE TABLE IF NOT EXISTS zbx_incident_timeline ( timelineid BIGINT NOT NULL, title VARCHAR(255) DEFAULT '' NOT NULL, description TEXT NOT NULL, incident_time BIGINT NOT NULL, end_time BIGINT DEFAULT 0 NOT NULL, status INT DEFAULT 0 NOT NULL, responsible VARCHAR(255) DEFAULT '' NOT NULL, PRIMARY KEY (timelineid) );"
fi

echo ""
echo "=========================================="
echo " Instalação Concluída!"
echo "=========================================="
echo "Para ativar o módulo no Zabbix:"
echo "1. Acesse o Zabbix via navegador."
echo "2. Vá em Administração -> Geral -> Módulos (ou Administração -> Módulos)."
echo "3. Clique em 'Scan directory' (Escanear diretório)."
echo "4. O módulo 'Timeline' aparecerá. Clique em 'Enable' (Ativar)."
echo "5. O menu 'Timeline' surgirá na aba Monitoring."
