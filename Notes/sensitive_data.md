## Sensitive data
When declaring a variable with sensitive data, use the ```sensitive``` attribute

```
variable "password" {
  type      = string
  sensitive = true
}
```