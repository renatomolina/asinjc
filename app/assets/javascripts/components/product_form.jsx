class ProductForm extends React.Component {
  render() {
    return (
      <div>
        <label>ASIN:</label>
        <input
          type="text"
          name="product[asin]"
        />
        <input type="submit" />
        <br/>
        <a href='/products'>See all amazon products</a>
      </div>
    )    
  }
}