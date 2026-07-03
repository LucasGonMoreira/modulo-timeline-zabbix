#!/bin/bash
# Zabbix Timeline Module Installer

echo "=========================================="
echo "  Instalador do Módulo Timeline - Zabbix"
echo "=========================================="
echo ""

# Find Zabbix UI Directory
ZABBIX_UI_DIR=""
if [ -d "/usr/share/zabbix/ui/modules" ]; then
    ZABBIX_UI_DIR="/usr/share/zabbix/ui"
elif [ -d "/usr/share/zabbix/modules" ]; then
    ZABBIX_UI_DIR="/usr/share/zabbix"
else
    echo "Erro: Diretório do Zabbix não encontrado. Este script suporta /usr/share/zabbix ou /usr/share/zabbix/ui."
    exit 1
fi

echo "Diretório do Zabbix encontrado em: $ZABBIX_UI_DIR"
MODULES_DIR="$ZABBIX_UI_DIR/modules"

# Decode and extract module payload
echo "Extraindo arquivos do módulo..."
PAYLOAD=$(cat << 'EOF'
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
Hf4PdiAiOwB4AAA=
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

read -p "Qual é a senha do usuário 'root' (ou 'zabbix') do banco de dados (aperte Enter se não houver ou se usar auth socket)? " DB_PASS

if [ -z "$DB_PASS" ]; then
    MYSQL_CMD="mysql -u root zabbix"
else
    MYSQL_CMD="mysql -u root -p\"$DB_PASS\" zabbix"
fi

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

echo "Executando script SQL..."
eval "$MYSQL_CMD -e \"\$SQL_QUERY\""

if [ $? -eq 0 ]; then
    echo "Tabela criada com sucesso!"
else
    echo "Aviso: Houve um erro ao criar a tabela. Talvez o banco não se chame 'zabbix' ou o usuário root requeira ajustes."
    echo "Você pode criar a tabela manualmente:"
    echo "$SQL_QUERY"
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
