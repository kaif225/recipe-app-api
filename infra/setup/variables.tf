variable "region" {
  default = "us-east-1"
}

variable "tf_state_file" {
  default = "kaif-devops-recipe-api"
}

variable "tf_state_locking_table" {
    default = "recipe-state-locking"
} 

variable "project" {
  default = "recipe-app-api"
}

variable "contact" {
  default = "kaifuusmani+devopspractice@gmail.com"
}