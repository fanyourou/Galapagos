package models.json
import
  org.nlogo.{ api, core, tortoise },
    api.LogoList,
      core.{ Widget, Button, Monitor, Output, Plot, Pen, Slider, Switch, TextBox, View, Chooser,
             Direction, Horizontal, Vertical, UpdateMode, InputBoxType, InputBox, AgentKind }

import
  play.api.libs.json.{JsString, Json, Reads, JsSuccess, JsError}

object WidgetReads {
  implicit val updateModeReads = Reads[UpdateMode] { json => json.toString.toUpperCase match {
    case "CONTINUOUS" => JsSuccess(UpdateMode.Continuous)
    case "TICKBASED"  => JsSuccess(UpdateMode.TickBased)
    case _            => JsError()
  }}

  implicit val viewReads = Json.reads[View]

  implicit val widgetReads = Reads[Widget] {
    json => ((json \ "type").as[String] match {
      case "view" => viewReads
    }).reads(json)
  }

  implicit val widgetsReads = Reads.list[Widget]

}
