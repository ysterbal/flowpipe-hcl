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