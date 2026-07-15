import Component from "@glimmer/component";
import { service } from "@ember/service";
import icon from "discourse/helpers/d-icon";
import { convertIconClass } from "discourse/lib/icon-library";

export default class TrustLevelAvatarFlair extends Component {
  @service site;

  get user() {
    return this.args.model;
  }

  get trustLevel() {
    return Number(this.user?.trust_level ?? 0);
  }

  get isTl0() {
    return this.trustLevel === 0;
  }

  get isTl1() {
    return this.trustLevel === 1;
  }

  get isTl2() {
    return this.trustLevel === 2;
  }

  get isTl3() {
    return this.trustLevel === 3;
  }

  get excludableNonhuman() {
    return settings.exclude_nonhuman_users && this.user?.id < 0;
  }

  get configuredFlair() {
    const values = [
      settings.new_user_flair_icon,
      settings.basic_user_flair_icon,
      settings.member_flair_icon,
      settings.regular_flair_icon,
      settings.leader_flair_icon,
    ];

    return values[this.trustLevel]?.trim?.() || "";
  }

  get isImage() {
    return /^https?:\/\//i.test(this.configuredFlair);
  }

  get trustLevelIcon() {
    const value = this.configuredFlair;

    if (settings.use_font_awesome && value.includes("fa-")) {
      return convertIconClass(value);
    }

    return null;
  }

  get trustLevelEmoji() {
    const value = this.configuredFlair;

    if (!value || this.isImage || this.trustLevelIcon) {
      return null;
    }

    return value;
  }

  get useMechaShield() {
    return settings.badge_style === "metal-shield" && !this.isImage;
  }

  get flairClass() {
    const classes = [
      `tl-${this.trustLevel}`,
      "tl-flair",
      `tl-flair-${this.user?.username}`,
    ];

    if (this.useMechaShield) {
      classes.push("tl-flair--mecha-shield");
    } else if (this.trustLevelEmoji) {
      classes.push("tl-flair--bare-emoji");
    }

    if (this.isImage) {
      classes.push("tl-flair--image");
    }

    return classes.join(" ");
  }

  get trustLevelName() {
    return this.site.trustLevels[this.trustLevel]?.name;
  }

  <template>
    {{#unless this.excludableNonhuman}}
      {{#if this.configuredFlair}}
        <div class="tl-avatar-flair">
          <div title={{this.trustLevelName}} class={{this.flairClass}}>
            {{#if this.useMechaShield}}
              <svg class="tl-mecha-badge" viewBox="0 0 64 72" aria-hidden="true">
                <g class="tl-mecha-badge__body">
                  <path
                    class="tl-mecha-badge__outer"
                    d="M32 2 60 11 59 42 52 59 32 71 12 59 5 42 4 11Z"
                  />
                  <path
                    class="tl-mecha-badge__gasket"
                    d="M32 8 53 15 52 39 46 53 32 62 18 53 12 39 11 15Z"
                  />
                  <path
                    class="tl-mecha-badge__panel"
                    d="M32 12 49 18 48 37 43 48 32 56 21 48 16 37 15 18Z"
                  />
                  <path
                    class="tl-mecha-badge__facet tl-mecha-badge__facet--light"
                    d="M15 18 32 12 25 30 16 37Z"
                  />
                  <path
                    class="tl-mecha-badge__facet tl-mecha-badge__facet--dark"
                    d="M49 18 32 12 39 30 48 37Z"
                  />
                  <path
                    class="tl-mecha-badge__facet tl-mecha-badge__facet--lower-dark"
                    d="M16 37 25 30 32 56 21 48Z"
                  />
                  <path
                    class="tl-mecha-badge__facet tl-mecha-badge__facet--lower-light"
                    d="M48 37 39 30 32 56 43 48Z"
                  />
                  <path
                    class="tl-mecha-badge__ridge"
                    d="M8 12 32 5 56 12 50 18 32 12 14 18Z"
                  />
                  <circle class="tl-mecha-badge__rivet" cx="10" cy="18" r="1.7" />
                  <circle class="tl-mecha-badge__rivet" cx="54" cy="18" r="1.7" />
                  <circle class="tl-mecha-badge__rivet" cx="15" cy="51" r="1.5" />
                  <circle class="tl-mecha-badge__rivet" cx="49" cy="51" r="1.5" />

                  <g class="tl-badge-icon">
                    {{#if this.isTl0}}
                      <path d="M32 48V30" />
                      <path d="M31 35C22 34 18 29 18 22c8-1 14 3 15 10" />
                      <path d="M33 30c2-7 7-10 14-9 0 7-5 12-14 12" />
                      <path d="M24 49h16" />
                    {{else if this.isTl1}}
                      <path class="tl-badge-icon__fill" d="M19 18 24 20 43 43 39 47 20 24Z" />
                      <path class="tl-badge-icon__soft-fill" d="M21 20 24 21 41 42 39 44 22 23Z" />
                      <path d="M37 43 43 49" />
                      <path d="M35 46 40 41" />
                      <path d="M42 49 46 53" />
                      <path class="tl-badge-icon__fill" d="M45 18 40 20 21 43 25 47 44 24Z" />
                      <path class="tl-badge-icon__soft-fill" d="M43 20 40 21 23 42 25 44 42 23Z" />
                      <path d="M27 43 21 49" />
                      <path d="M29 46 24 41" />
                      <path d="M22 49 18 53" />
                    {{else if this.isTl2}}
                      <path d="m24 19 8 11 8-11" />
                      <circle cx="32" cy="40" r="11" />
                      <path
                        class="tl-badge-icon__fill"
                        d="m32 33 2.4 4.7 5.3.8-3.8 3.8.9 5.4-4.8-2.5-4.8 2.5.9-5.4-3.8-3.8 5.3-.8Z"
                      />
                    {{else if this.isTl3}}
                      <path
                        class="tl-badge-icon__soft-fill"
                        d="m19 28 7-9h12l7 9-13 21Z"
                      />
                      <path d="M19 28h26M26 19l6 9 6-9M32 28v21" />
                    {{else}}
                      <path
                        class="tl-badge-icon__soft-fill"
                        d="m18 43-3-18 10 8 7-14 7 14 10-8-3 18Z"
                      />
                      <path d="M19 48h26" />
                      <circle class="tl-badge-icon__fill" cx="15" cy="24" r="2" />
                      <circle class="tl-badge-icon__fill" cx="32" cy="18" r="2" />
                      <circle class="tl-badge-icon__fill" cx="49" cy="24" r="2" />
                    {{/if}}
                  </g>
                </g>
              </svg>
            {{else if this.trustLevelIcon}}
              <span class="tl-flair-symbol">{{icon this.trustLevelIcon}}</span>
            {{else if this.trustLevelEmoji}}
              <span class="tl-flair-symbol tl-flair-emoji" aria-hidden="true">{{this.trustLevelEmoji}}</span>
            {{/if}}
          </div>
        </div>
      {{/if}}
    {{/unless}}
  </template>
}
