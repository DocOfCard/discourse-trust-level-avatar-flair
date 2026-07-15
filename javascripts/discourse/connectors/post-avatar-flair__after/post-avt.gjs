import Component from "@ember/component";
import { classNames, tagName } from "@ember-decorators/component";
import TrustLevelAvatarFlair from "../../components/trust-level-avatar-flair";

@tagName("div")
@classNames("post-avt")
export default class TrustLevelFlairConnector extends Component {
  <template><TrustLevelAvatarFlair @model={{@outletArgs.user}} /></template>
}
