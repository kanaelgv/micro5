{{- define "app.chart" -}}                                        # формируем красивое имя чарта с версией
{{- printf "%s-%s" .Chart.Name .Chart.Version }}
{{- end }}

{{- define "app.selectorLabels" -}}                               # определяем лейблы по которым стыкуются ресурсы
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "app.labels" -}}                                       # добавляем больше лейблов
helm.sh/chart: {{ include "app.chart" . }}
{{ include "app.selectorLabels" . }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "app.standOpts" -}}
  {{- if has .Values.app.standName (list "dev") -}}
    "eto dev stand "
  {{- else if has .Values.app.standName (list "test") -}}
    "eto test stand "
  {{- else -}}
    "standName ne ukazan"
  {{- end -}}
{{- end -}}

{{- define "app.app_Opts" -}}                                     # здесь может быть блок настроек от вашего приложения
    "--eto nabor nastroek"
{{- end -}}

{{- define "todos-api.EnvStartup" }}                              # блок с описанием переменных окружения

- name: SAMPLE_OPTS                                               # блок переменных из шаблона
  value: {{ template "app.app_Opts" . }}

- name: STAND_OPTS                                               # блок переменных из шаблона
  value: {{ template "app.standOpts" . }}

- name: SAMPLE_ENV                                                # блок переменных из values
  value: "{{ .Values.sample.env }}"

- name: TODO_API_PORT
  value: "{{ .Values.todos_api.port }}"
- name: REDIS_HOST
  value: "{{ .Values.redis.host }}"
- name: REDIS_PORT
  value: "{{ .Values.redis.port }}"
- name: REDIS_CHANNEL
  value: "{{ .Values.redis.log_channel }}"
- name: ZIPKIN_HOST
  value: "{{ .Values.zipkin.host }}"
- name: ZIPKIN_PORT
  value: "{{ .Values.zipkin.port }}"
- name: ZIPKIN_URL
  value: "{{ .Values.zipkin.url }}"

- name: SAMPLE_SECRET_ENV                                         # блок переменных из секрета
  valueFrom:
    secretKeyRef:
      name: "{{ .Values.app.name }}"
      key: SECRET_ENV

- name: JWT_SECRET                                         # блок переменных из секрета
  valueFrom:
    secretKeyRef:
      name: "{{ .Values.app.name }}"
      key: SECRET_ENV
 
- name: SAMPLE_CONFIG_ENV                                         # блок переменных из конфигмапы
  valueFrom:
    configMapKeyRef:
      name: "{{ .Values.app.name }}"
      key: CONFIG_ENV
{{- end }}
