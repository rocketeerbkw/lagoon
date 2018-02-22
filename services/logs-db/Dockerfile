ARG IMAGE_REPO
FROM ${IMAGE_REPO:-lagoon}/elasticsearch

ENV LOGSDB_SLACK_WEBHOOK_URL https://hooks.slack.com/services/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
ENV LOGSDB_SLACK_USERNAME lagoon-watcher
ENV LOGSDB_SLACK_CHANNEL #lagoon-dev-alerts
ENV LOGSDB_PAGERDUTY_KEY XXXXU4yGzC2QassuXXXX

COPY conf/elasticsearch.yml /usr/share/elasticsearch/config/elasticsearch.yml
