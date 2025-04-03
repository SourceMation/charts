{{/* vim: set filetype=mustache: */}}

{{/* Define common labels */}}
{{- define "common.labels" -}}
app.kubernetes.io/name: {{ .Release.Name }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
app.kubernetes.io/component: middleware
{{- if .Values.labels }}
{{- range $labelkey, $labelvalue := .Values.labels }}
{{ $labelkey}}: {{ $labelvalue }}
{{- end }}
{{- end }}
{{- end -}}