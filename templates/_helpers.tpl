{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "app.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/* Default Labels: Helm recommended best-practice labels https://helm.sh/docs/chart_best_practices/labels/ */}}
{{- define "app.defaultLabels" }}
app.kubernetes.io/name: {{ include "app.fullname" . }}
app.kubernetes.io/namespace: {{ .Release.Namespace }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.Version }}
app.kubernetes.io/app-version: {{ .Chart.AppVersion }}
app.openshift.io/runtime: quarkus
app.openshift.io/runtime-namespace: {{ .Release.Namespace }}
app.openshift.io/runtime-version: {{ .Chart.AppVersion }}
{{- end -}}

{{- define "app.srcGit" }}
{{- printf "https://github.com/gmodzelewski/octo-happiness-%s.git" .Values.design -}}
{{- end -}}

{{- define "app.image" }}
{{- if .Values.imageOverride -}}
{{- .Values.imageOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "quay.io/modzelewski/octo-happiness-%s" .Values.design -}}
{{- end -}}
{{- end -}}

{{- define "app.helmGit" }}
{{- printf "https://github.com/gmodzelewski/octo-happiness.git" -}}
{{- end -}}

{{- define "app.defaultAnnotations" }}
app.openshift.io/vcs-uri: {{ include "app.srcGit" . }}
{{- end -}}

{{- define "app.matchLabels" }}
app.kubernetes.io/name: {{ include "app.fullname" . }}
app.kubernetes.io/namespace: {{ .Release.Namespace }}
{{- end -}}