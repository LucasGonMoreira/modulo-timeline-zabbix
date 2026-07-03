  # Zabbix Incident Timeline 🚨

    Um módulo customizado e interativo para **Zabbix (versões 7.0, 7.2, 7.4 e superiores)** que adiciona uma nova aba
  de "Timeline" na seção de Monitoramento (Monitoring). Perfeito para registrar incidentes, falhas de rede, paradas
  de manutenção e manter todas as equipes da sua infraestrutura alinhadas.

    ## 🚀 Funcionalidades Principais

    - **Integração Nativa com Zabbix (Modais):** Construído 100% sobre o motor MVC do Zabbix utilizando os painéis
    - **CRUD Completo:** Crie, edite, visualize e exclua registros de incidentes de forma rápida.
  flutuantes interativos nativos (`PopUp` overlay dialogue). Zero redirecionamentos de página.
    - **Automação de Encerramento (End Time):** Ao editar o status do incidente para "Resolvido", o sistema captura
  automaticamente o *timestamp* exato do servidor e registra o horário de término.
    - **Proteção Anti-CSRF:** Integrado ao sistema de segurança moderno do Zabbix para proteção contra requisições
  maliciosas.

    ## ⚙️ Compatibilidade

    - **Zabbix:** 7.0 LTS, 7.2, 7.4+
    - **PHP:** 8.0+
    - **Banco de Dados:** MySQL / MariaDB

    ## 📦 Instalação Mágica (One-Click)

    Criamos um instalador automático em Bash para facilitar o deploy do módulo em qualquer servidor sem precisar
  copiar pastas manualmente.

    1. Baixe o script de instalação para o servidor do Zabbix Frontend:
       ```bash
       # wget https://raw.githubusercontent.com/SEU-USUARIO/zabbix-timeline-module/main/install_zabbix_timeline.sh

  2. Dê permissão de execução e inicie o script:
    chmod +x install_zabbix_timeline.sh
    ./install_zabbix_timeline.sh

  3. O script fará:
      • Detecção automática do diretório da UI do Zabbix.
      • Extração do código base em tempo real.
      • Ajuste de permissões e privilégios.
      • Criação da tabela customizada  zbx_incident_timeline  no banco de dados.


  ## 🖱️ Ativação na Interface Web

  Após executar o script no terminal, conclua a ativação pela interface do Zabbix:

  1. Faça login no seu Zabbix.
  2. Navegue até Administration -> General -> Modules (Administração -> Geral -> Módulos).
  3. Clique no botão Scan directory (Escanear diretório).
  4. O módulo Timeline aparecerá na lista.
  5. Clique em Enable (Ativar).
  6. Pronto! O menu Timeline já estará disponível dentro da aba principal de Monitoring (Monitoramento).

  ## 🛠️ Estrutura do Banco de Dados

  Caso prefira criar a tabela manualmente (em vez de usar o instalador), utilize o SQL abaixo no banco da sua
  instalação:

    CREATE TABLE IF NOT EXISTS zbx_incident_timeline (
        timelineid BIGINT UNSIGNED NOT NULL,
        title VARCHAR(255) DEFAULT '' NOT NULL,
        description TEXT NOT NULL,
        incident_time BIGINT UNSIGNED NOT NULL,
        end_time BIGINT UNSIGNED DEFAULT 0 NOT NULL,
        status INT DEFAULT 0 NOT NULL,
        responsible VARCHAR(255) DEFAULT '' NOT NULL,
        PRIMARY KEY (timelineid)
    );
