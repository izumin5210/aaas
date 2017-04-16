/* @flow */
import { PureComponent } from 'react'

type Props = {
  values: Array<string>,
}

export default class ApplicationValues extends PureComponent<void, Props, void> {
  static renderItem (value: string) {
    return (
      <li className='item' key={value}>{ value }</li>
    )
  }

  // for lint
  props: Props

  renderItems () {
    return this.props.values
      .map(ApplicationValues.renderItem)
  }

  render () {
    return (
      <ul className='list'>
        { this.renderItems() }
      </ul>
    )
  }
}
