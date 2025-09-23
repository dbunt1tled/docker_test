{{/* helpers.tpl */}}
{{- define "inwebapp.name" -}}
{{- default .Chart.Name .Values.nameOverride -}}
{{- end }}

{{- define "inwebapp.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride -}}
{{- else -}}
{{- include "inwebapp.name" . -}}
{{- end -}}
{{- end }}

{{- define "inwebapp.labels" -}}
app.kubernetes.io/name: {{ include "inwebapp.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion | default "dev" }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version }}
{{- end }}

{{- define "inwebapp.selectorLabels" -}}
app.kubernetes.io/name: {{ include "inwebapp.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}