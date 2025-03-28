{{- define "calculateEntSearchJavaMemory" -}}
{{- $memory := .Values.enterpriseSearch.params.memory -}}
{{- if regexMatch "Gi$" $memory -}}
  {{- $memoryValue := regexReplaceAll "Gi" $memory "" | int -}}
  {{- $memoryInMi := mul $memoryValue 1024 -}}
  {{- $reducedMemoryInMi := mulf $memoryInMi 0.95 | int -}}
  {{- printf "%dm" $reducedMemoryInMi -}}
{{- else if regexMatch "Mi$" $memory -}}
  {{- $memoryValue := regexReplaceAll "Mi" $memory "" | int -}}
  {{- $reducedMemory := mulf $memoryValue 0.95 | int -}}
  {{- printf "%dm" $reducedMemory -}}
{{- else -}}
  {{- fail "Unsupported memory unit. Please specify memory in Gi or Mi." -}}
{{- end -}}
{{- end -}}