$.Tabs = function (el) {
  this.$el = $(el);
  this.$contentTabs = $(this.$el.data("content-tabs"));
  this.$activeTab = this.$el.find(".active");
  this.$activeContentTab = this.$contentTabs.find(this.$activeTab.attr('href'));
  this.$el.on("click", "a", this.clickTab.bind(this));
};

$.fn.tabs = function () {
  return this.each(function () {
    new $.Tabs(this);
  });
};


$.Tabs.prototype.clickTab = function (event) {
  event.preventDefault();

  this.$activeTab.removeClass('active');
  this.$activeContentTab.removeClass('active');

  this.$activeTab = $(event.currentTarget);
  this.$activeTab.addClass('active');
  this.$activeContentTab = this.$contentTabs.find(this.$activeTab.attr('href'));
  this.$activeContentTab.addClass("active");
};
