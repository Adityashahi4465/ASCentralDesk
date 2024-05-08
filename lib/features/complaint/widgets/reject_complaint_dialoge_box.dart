import 'package:flutter/material.dart';

class RejectComplaintBottomSheet extends StatelessWidget {
  const RejectComplaintBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showCustomSnackbar(
        context,
        "Double Tap to Reject the complaint",
      ),
      onDoubleTap: () {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return StatefulBuilder(
              builder: (context, setState) {
                String selectedReason = ""; // Track the selected reason

                return Container(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Select a reason:"),
                      // Use ChoiceChip for default reasons
                      ChoiceChip(
                        label: Text("Reason 1"),
                        selected: selectedReason == "Reason 1",
                        onSelected: (selected) {
                          setState(() {
                            selectedReason = selected ? "Reason 1" : "";
                          });
                        },
                      ),
                      ChoiceChip(
                        label: Text("Reason 2"),
                        selected: selectedReason == "Reason 2",
                        onSelected: (selected) {
                          setState(() {
                            selectedReason = selected ? "Reason 2" : "";
                          });
                        },
                      ),
                      // Add other default reasons as needed

                      // Option for entering custom consults
                      ListTile(
                        title: Text("Other"),
                        onTap: () {
                          Navigator.pop(context);
                          // Show a text field to enter custom consults
                          showCustomTextfieldBottomSheet(context);
                        },
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Handle button press with selectedReason
                          handleReject(selectedReason);
                          Navigator.pop(context);
                        },
                        child: Text("Submit"),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
      child: Container(
        width: (0.9 * MediaQuery.of(context).size.width - 25) / 3,
        height: (0.6 * MediaQuery.of(context).size.height - 25) / 3,
        color: Color(0xFF181D3D),
        // Add your container content here
      ),
    );
  }

  void handleReject(String selectedReason) {
    // Implement logic to handle rejection with the selected reason
    print("Rejected with reason: $selectedReason");
  }

  void showCustomTextfieldBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Enter custom consults:"),
              TextField(
                decoration: InputDecoration(
                  hintText: "Type here...",
                ),
                // Handle the input as needed
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle button press
                  Navigator.pop(context);
                },
                child: Text("Submit"),
              ),
            ],
          ),
        );
      },
    );
  }

  void showCustomSnackbar(BuildContext context, String message) {
    // Implement custom snackbar logic
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
