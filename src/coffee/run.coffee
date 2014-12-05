$(->

  tabnParam =
    tabs: '.tab__list'
    tab: '.tab__item'
    contents: '.tab__content'
    content: '.tab__body'
    animation: true

  if $('.tab--tab01')[0]
    $('.tab--tab01').tabn tabnParam
)
