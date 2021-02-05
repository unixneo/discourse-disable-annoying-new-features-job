# discourse-disable-annoying-new-features-notice

#### What Does this Plugin Do

This simple Discourse plugin marks the "new features" notice in the admin dashboard, *which I find very annoying*, as "seen" so Discourse self-hosting admins do not have to see this annoying notice and dismiss the notice over and over again (especially after we rebuild a container).

Discourse admins can also hide this, as below, but I prefer do use this plugin to mark the new features as "seen" and insure this code is not displayed in the DOM.

```css
div.dashboard-new-features {
  display: none;
}
```

See Also:

https://community.unix.com/t/discourse-disable-annoying-new-features-notice-plugin/381654
