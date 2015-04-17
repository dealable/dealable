menuItemClass = (routeName) ->
  if !Router.current() or !Router.current().route
    return ''
  if !Router.routes[routeName]
    return ''
  currentPath = Router.routes[Router.current().route.getName()].handler.path
  routePath = Router.routes[routeName].handler.path
  if routePath == '/'
    return if currentPath == routePath then 'active' else ''
  if currentPath.indexOf(routePath) == 0 then 'active' else ''

Template.registerHelper "menuItemClass", menuItemClass
