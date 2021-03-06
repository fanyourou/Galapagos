package models.local

import
  java.io.File

import
  akka.actor.Actor

import
  play.api.{ Application, cache },
    cache.Cache

class StatusCacher(implicit app: Application) extends Actor {
  import StatusCacher.{ AllBuiltInModels, AllBuiltInModelsCacheKey }
  override def receive: Receive = {
    case AllBuiltInModels(files)        => Cache.set(AllBuiltInModelsCacheKey, files.map(_.getPath))
    case status: ModelCompilationStatus => Cache.set(status.file.getPath, status)
  }
}

object StatusCacher {
  val AllBuiltInModelsCacheKey = "allModelCompilationStatuses"
  private[local] case class AllBuiltInModels(models: Seq[File])
}
