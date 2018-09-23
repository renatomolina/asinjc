class ProductList extends React.Component {
  render() {
    return (
      <div>
        <hr/>
        <h2>Products</h2>
        {this.props.products.length !== 0 ?
          this.props.products.map((product) => <ProductItem product={product}/>)
          : <span>There are no products registered.</span>}
      </div>
    )    
  }
}