#!/bin/bash
# Zabbix Timeline Module Uninstaller

echo "=========================================="
echo "  Desinstalador do Módulo Timeline - Zabbix"
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

# Remove module files
TIMELINE_DIR="$MODULES_DIR/timeline"

if [ -d "$TIMELINE_DIR" ]; then
    echo "Removendo arquivos do módulo..."
    rm -rf "$TIMELINE_DIR"
    if [ $? -eq 0 ]; then
        echo "Módulo removido com sucesso de $TIMELINE_DIR."
    else
        echo "Erro ao remover os arquivos do módulo. Verifique as permissões."
    fi
else
    echo "O diretório do módulo não foi encontrado em $TIMELINE_DIR. Os arquivos já podem ter sido removidos."
fi

echo ""
echo "=========================================="
echo " Configuração do Banco de Dados"
echo "=========================================="
echo "A tabela 'zbx_incident_timeline' foi criada durante a instalação."

read -p "Deseja remover a tabela do banco de dados automaticamente agora? (ISSO APAGARÁ TODOS OS DADOS DA TIMELINE) (s/n): " RUN_DB
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
        SQL_QUERY="DROP TABLE IF EXISTS zbx_incident_timeline;"
        MYSQL_CMD="mysql -u \"$DB_USER\" -h \"$DB_HOST\""
        if [ -n "$DB_PASS" ]; then
            MYSQL_CMD="$MYSQL_CMD -p\"$DB_PASS\""
        fi
        MYSQL_CMD="$MYSQL_CMD \"$DB_NAME\""

        echo "Executando script SQL no MySQL/MariaDB..."
        eval "$MYSQL_CMD -e \"\$SQL_QUERY\""

        if [ $? -eq 0 ]; then
            echo "Tabela removida com sucesso!"
        else
            echo "Aviso: Houve um erro ao remover a tabela no MySQL."
        fi
    elif [ "$DB_TYPE" = "2" ]; then
        SQL_QUERY="DROP TABLE IF EXISTS zbx_incident_timeline;"
        export PGPASSWORD="$DB_PASS"
        echo "Executando script SQL no PostgreSQL..."
        psql -U "$DB_USER" -h "$DB_HOST" -d "$DB_NAME" -c "$SQL_QUERY"

        if [ $? -eq 0 ]; then
            echo "Tabela removida com sucesso!"
        else
            echo "Aviso: Houve um erro ao remover a tabela no PostgreSQL."
        fi
    else
        echo "Opção inválida."
    fi
else
    echo "Você optou por não remover a tabela automaticamente."
    echo "Caso deseje remover futuramente, rode o seguinte comando no seu banco de dados:"
    echo "DROP TABLE IF EXISTS zbx_incident_timeline;"
fi

echo ""
echo "=========================================="
echo " Desinstalação Concluída!"
echo "=========================================="
echo "Nota: Caso você já tenha desativado o módulo pela interface web do Zabbix,"
echo "nenhuma ação adicional é necessária. Caso o módulo estivesse ativo, o Zabbix"
echo "deixará de carregá-lo automaticamente com a remoção dos arquivos."
