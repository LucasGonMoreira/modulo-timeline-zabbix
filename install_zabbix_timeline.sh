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
U57ylKc85SlPecrT80r/D+CI6wIA8AAA
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
