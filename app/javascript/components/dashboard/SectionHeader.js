/* @flow */
import { PureComponent } from 'react'

type Props = {
  title: string,
  icon: string,
}

export default class SectionHeader extends PureComponent<void, Props, void> {
  render() {
    const { title, icon } = this.props;
    return (
      <header className="Dashboard__header" key="SectionHeader">
        <h2 className="Dashboard__heading">
          <i className={`fa fa-${icon}`} />
          { title }
        </h2>
      </header>
    )
  }
}
