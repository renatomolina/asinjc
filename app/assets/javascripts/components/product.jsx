class Product extends React.Component {
  render() {
    return (
      <div>
        <label>ASIN:</label>
        <label>{this.props.product.asin}</label>
        <br/>
        
        <label>Dimensions:</label>
        <label>{this.props.product.dimensions}</label>
        <br/>

        <label>Rank:</label>
        <label>{this.props.product.rank}</label>
        <br/>

        <label>Category:</label>
        <label>{this.props.product.category}</label>
        <br/>
        <hr/>
      </div>
    )    
  }
}