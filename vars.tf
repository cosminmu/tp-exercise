variable "environments" {
  type = map(object({
        asbn_names = list(string)
  }))
}