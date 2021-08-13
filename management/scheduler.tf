module "scheduler" {
  source = "../modules/scheduler"

  common     = local.common
  scheduler  = local.scheduler
}
