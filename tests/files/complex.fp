locals {
  pipes_api_version = "latest"
  pipes_baseurl     = "https://pipes.turbot.com"
  pipes_cred_file   = "~/.steampipe/internal/pipes.turbot.com.tptt" 
}

locals {
  pipes_api_url     = "${local.pipes_baseurl}/api/${local.pipes_api_version}" 
}

pipeline "list_my_workspaces" {
  step "http" "list_workspaces" {
    url = "${local.pipes_api_url}/actor/workspace"
    request_headers = {
      Authorization = "Bearer ${file(local.pipes_cred_file)}"
    }
  }

  output "workspaces" {
    value = step.http.list_workspaces.response_body.items[*].handle
  }
}