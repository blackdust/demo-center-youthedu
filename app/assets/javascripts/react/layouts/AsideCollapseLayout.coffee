{ Menu, Icon, Breadcrumb, Alert} = antd

module.exports = AsideCollapseLayout = React.createClass
  getInitialState: ->
    collapse: false

  change_collapse: ->
    @setState collapse: not @state.collapse
  
  render: ->
    breadcrumb = 
      <div className='ant-layout-breadcrumb'>
        <Breadcrumb>
          <Breadcrumb.Item><Icon type='home' /> 演示中心</Breadcrumb.Item>
          <Breadcrumb.Item>个人学习中心</Breadcrumb.Item>
          <Breadcrumb.Item>演示页</Breadcrumb.Item>
        </Breadcrumb>
      </div>

    classes = ClassName
      'ant-layout-aside': true
      'ant-layout-aside-collapse': @state.collapse

    <div className={classes}>
      <Aside 
        slides={@props.slides}
        collapse={@state.collapse} 
        change_collapse={@change_collapse}
      />

      <div className="ant-layout-main">
        {breadcrumb}

        <div className="ant-layout-container">
          <div className="ant-layout-content">
            {
              try
                console.log "render content component: ", @props.content_component.name
                React.createElement eval(@props.content_component.name), null
              catch e
                <Alert
                  message='页面组件渲染错误'
                  description="#{e}"
                  type='error'
                  showIcon
                />
            }
          </div>
        </div>
        <div className="ant-layout-footer">
          Powered by Knowledge Camp
        </div>
      </div>

    </div>


Aside = React.createClass
  render: ->
    aside_action =
      <div className='ant-aside-action' onClick={@props.change_collapse}>
        <Icon type={if @props.collapse then 'right' else 'left'} />
      </div>

    <aside className='ant-layout-sider'>
      <Menu mode='inline' theme='dark' defaultSelectedKeys={['1']}>
      {
        for slide in @props.slides
          <Menu.Item key={slide.id}>
            <Icon type='laptop' /><span className='nav-text'>{slide.name}</span>
          </Menu.Item>
      }
      </Menu>

      {aside_action}
    </aside>