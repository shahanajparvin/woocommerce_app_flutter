
<h1 align="center">
  WooCommerce Flutter App
</h1>

<p align="center">
Flutter WooCommerce App: A sleek e-commerce mobile app integrated with WooCommerce API. Built on Flutter using Bloc pattern for state management, it enables seamless browsing of products, viewing details, and smooth checkout. Delivering a modern shopping experience, it empowers users to shop effortlessly on your WooCommerce store.
</p>


<p align="center">
  <img alt="Logo" src="https://github.com/shahanajparvin/woocommerce_app_flutter/assets/17999879/a0f31598-860c-43d0-9c97-c2d06ace594d" />
</p>



<h2>Overview</h2>

<p>
  This app demonstrates how to build a cross-platform mobile application using Flutter to interact with the WooCommerce API and manage state with the Bloc pattern. It allows users to browse products, add them to the cart, and make purchases through the WooCommerce online store.
</p>

<h2>Features</h2>

<ul>
  <li>Product listing: Display a list of products fetched from the WooCommerce API.</li>
  <li>Product details: Show detailed information about a selected product.</li>
  <li>Add to cart: Allow users to add products to their shopping cart.</li>
  <li>Cart management: Users can view and modify the contents of their shopping cart.</li>
  <li>Checkout: Provide a seamless checkout experience using the WooCommerce API.</li>
</ul>

<h2>Installation</h2>

<p>
  Follow these steps to set up the project:
</p>

<ol>
  <li>Clone the repository to your local machine.</li>

<pre><code>git clone https://github.com/your-username/woocommerce-flutter-app.git</code></pre>

  <li>Open the project in your preferred Flutter development environment (Android Studio, VS Code, etc.).</li>

  <li>Install the dependencies by running:</li>

<pre><code>flutter pub get</code></pre>

  <li>Create a new file named <code>config.dart</code> in the <code>lib</code> folder to store your WooCommerce API credentials:</li>

<pre><code>// lib/config.dart

const String baseUrl = 'https://your-woocommerce-store-url.com/wp-json/wc/v3/';
const String consumerKey = 'YOUR_CONSUMER_KEY';
const String consumerSecret = 'YOUR_CONSUMER_SECRET';</code></pre>

  <p>Replace <code>YOUR_CONSUMER_KEY</code> and <code>YOUR_CONSUMER_SECRET</code> with your actual WooCommerce API credentials. You can obtain these credentials from your WooCommerce store's admin panel.</p>
</ol>

<h2>How to Use</h2>

<p>
  This app follows the Bloc pattern for state management, which separates the business logic from the UI. The app's main components are organized as follows:
</p>

<ul>
  <li><strong>Models</strong>: Contains the data models used in the app, such as <code>Product</code>, <code>CartItem</code>, etc.</li>
  <li><strong>Providers</strong>: Contains the <code>ProductProvider</code> and <code>CartProvider</code> classes responsible for handling API calls and managing state related to products and the shopping cart.</li>
  <li><strong>Blocs</strong>: Contains the <code>ProductBloc</code> and <code>CartBloc</code> classes that handle the business logic and interact with the providers.</li>
  <li><strong>Screens</strong>: Contains the different screens of the app, such as the product listing screen, product details screen, and cart screen.</li>
  <li><strong>Widgets</strong>: Contains various reusable widgets used throughout the app.</li>
</ul>

<p>
  Please refer to the code and documentation in each file to understand how the different components work together.
</p>

<h2>Contributing</h2>

<p>
  Contributions to this project are welcome! Feel free to open issues for bugs or feature requests. If you'd like to contribute code, please fork the repository and create a pull request.
</p>

<h2>License</h2>

<p>
  This project is licensed under the <a href="LICENSE">MIT License</a>.
</p>

<h2>Acknowledgments</h2>

<p>
  Thanks to the <a href="https://woocommerce.com/">WooCommerce</a> team for providing a powerful API to build e-commerce applications.
  The architecture and patterns used in this app are inspired by various open-source projects and online resources.
</p>

<h2>Contact</h2>

<p>
  If you have any questions or need assistance, feel free to contact the project owner at your-email@example.com.
</p>

<div align="center">
  <img alt="Screenshot" src="screenshot.png" width="600">
</div>

<h2>Screenshots</h2>

<div align="center">
  <img alt="Screenshot 1" src="screenshots/screenshot1.png" width="200">
  <img alt="Screenshot 2" src="screenshots/screenshot2.png" width="200">
  <!-- Add more screenshots here -->
</div>

<h2>Tech Stack</h2>

<ul>
  <li>Flutter</li>
  <li>REST API</li>
  <li>Bloc pattern</li>
</ul>

<h2>Resources</h2>

<p>
  Here are some useful resources to get started with Flutter, REST API, and Bloc:
</p>

<ul>
  <li><a href="https://flutter.dev/docs" target="_blank">Flutter Documentation</a></li>
  <li><a href="https://www.restapitutorial.com/" target="_blank">REST API Tutorial</a></li>
  <li><a href="https://pub.dev/packages/flutter_bloc" target="_blank">Bloc Library</a></li>
</ul>

<h2>How to Contribute</h2>

<p>
  We welcome contributions from the community! If you'd like to contribute to this project, please follow these steps:
</p>

<ol>
  <li>Fork the repository on GitHub.</li>
  <li>Create a new branch from the <code>main</code> branch.</li>
  <li>Make your changes and commit them.</li>
  <li>Push your changes to your forked repository.</li>
  <li>Submit a pull request to the <code>main</code> branch of this repository.</li>
</ol>

<h2>License</h2>

<p>
  This project is licensed under the MIT License - see the <a href="LICENSE">LICENSE</a> file for details.
</p>

<h2>Contact</h2>

<p>
  For any inquiries or questions, you can reach us at putulcse9@example.com.
</p>

<div align="center">
  <p>Powered by <a href="https://flutter.dev" target="_blank">Flutter</a></p>
  <p>Made with ❤️ by [Your Name]</p>
</div>
