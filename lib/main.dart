import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

/// The main entry point of the application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Removes the debug banner.
      title: 'Demo for currency picker package', // Title of the app
      theme: ThemeData.dark(), // Sets the app theme to dark mode.
      home: const HomePage(), // Sets the HomePage as the initial screen.
    );
  }
}

/// HomePage widget that demonstrates the currency picker functionality.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// Initialize with Indian Rupee (INR) as the default currency.
  Currency _selectedCurrency = Currency(
    code: 'INR',
    name: 'Indian Rupee',
    namePlural: '',
    decimalSeparator: '',
    symbol: '₹',
    decimalDigits: 0,
    spaceBetweenAmountAndSymbol: false,
    symbolOnLeft: false,
    thousandsSeparator: '',
    flag: '🇮🇳',
    number: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Picker'), // Title in the app bar.
        centerTitle: true, // Centers the title in the app bar.
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Adds padding around the content.
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Centers the content vertically.
          children: [
            /// Button to trigger the currency picker.
            SizedBox(
              width: double.infinity, // Makes the button span the full width.
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, // Sets text color.
                  backgroundColor: Colors.blueAccent, // Sets button color.
                ),
                onPressed: () {
                  // Displays the currency picker when the button is pressed.
                  showCurrencyPicker(
                    context: context,
                    theme: CurrencyPickerThemeData(
                      bottomSheetHeight:
                          MediaQuery.of(context).size.height / 1.5,
                    ), // Customizes the picker height.
                    showFlag: true, // Displays the flag of the currency.
                    showSearchField:
                        true, // Adds a search field for convenience.
                    showCurrencyName: true, // Displays the currency name.
                    showCurrencyCode: true, // Displays the currency code.
                    favorite: [
                      'inr',
                      'usd',
                      'eur'
                    ], // Highlights these currencies.
                    onSelect: (Currency currency) {
                      // Updates the selected currency state.
                      setState(() {
                        _selectedCurrency = currency;
                      });
                    },
                  );
                },
                child: const Text('Show currency picker'), // Button label.
              ),
            ),
            const SizedBox(height: 20),

            /// TextFormField for entering an amount.
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Amount', // Label for the input field.
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(
                      15.0), // Adds padding to the prefix icon.
                  child: Text(
                    _selectedCurrency
                        .symbol, // Displays the selected currency symbol.
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors
                          .deepOrange, // Custom color for the prefix text.
                    ),
                  ),
                ),
                border:
                    const OutlineInputBorder(), // Adds a border to the input field.
              ),
              keyboardType:
                  TextInputType.number, // Restricts input to numbers only.
            ),
            const SizedBox(height: 20),

            /// Row of containers displaying preset currency amounts.
            Row(
              mainAxisAlignment: MainAxisAlignment
                  .spaceEvenly, // Evenly spaces the containers.
              children: [
                _buildCurrencyContainer(100), // Container for 100 units.
                _buildCurrencyContainer(500), // Container for 500 units.
                _buildCurrencyContainer(1000), // Container for 1000 units.
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Helper function to create a container displaying an amount with the currency symbol.
  Widget _buildCurrencyContainer(int amount) {
    return Container(
      width: 100, // Fixed width.
      height: 50, // Fixed height.
      decoration: BoxDecoration(
        color: Colors.blueAccent, // Background color.
        borderRadius: BorderRadius.circular(8.0), // Rounded corners.
      ),
      child: Center(
        child: Text(
          '${_selectedCurrency.symbol} $amount', // Displays the currency symbol and amount.
          style: const TextStyle(
            color: Colors.white, // Text color.
            fontSize: 16, // Font size.
            fontWeight: FontWeight.bold, // Bold text.
          ),
        ),
      ),
    );
  }
}
