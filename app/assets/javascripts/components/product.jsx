class Product extends React.Component {
  render() {
    return (
      <div>
        <strong>ASIN: </strong>
        <span>{this.props.product.asin}</span>
        <br/>
        
        <strong>Dimensions: </strong>
        <span>{this.props.product.dimensions}</span>
        <br/>

        <strong>Rank: </strong>
        <span>{this.props.product.rank}</span>
        <br/>

        <strong>Category: </strong>
        <span>{this.props.product.category}</span>
        <br/>
        <hr/>
      </div>
    )    
  }
}