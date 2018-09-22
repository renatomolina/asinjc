class ProductForm extends React.Component {
  render() {
    return (
      <div>
        <h2>Welcome friend!</h2>
        <label>Type ASIN:</label>
        <input
          type="text"
          name="product[asin]"
        />
        <input type="submit" />
      </div>
    )    
  }
}