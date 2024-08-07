const colours = [
    "#FFFFFF",
    "#808080",
    "#FF0000",
    "#FFFF00",
    "#808000",
    "#008000",
    "#00FFFF",
    "#008080",
    "#0000FF",
    "#FF00FF",
    "#800080",
];

function resizeTable() {
    const rows = parseInt(document.getElementById('rows').value, 10);
    const cols = parseInt(document.getElementById('cols').value, 10);
    const table = document.getElementById('myTable');

    // Clear the table
    table.querySelector('thead').innerHTML = '';
    table.querySelector('tbody').innerHTML = '';

    // Create table headers
    const thead = table.querySelector('thead');
    const headerRow = document.createElement('tr');
    for (let i = 0; i < cols; i++) {
        const th = document.createElement('th');
        th.textContent = `Header ${i + 1}`;
        headerRow.appendChild(th);
    }
    thead.appendChild(headerRow);

    // Create table rows
    const tbody = table.querySelector('tbody');
    for (let i = 0; i < rows; i++) {
        const row = document.createElement('tr');
        for (let j = 0; j < cols; j++) {
            const td = document.createElement('td');
            td.textContent = '0'; // Initialize each cell with 0
            td.contentEditable = 'true'; // Make cell editable
            td.addEventListener('click', function () {
                updateCellValue(this); // Update cell value when clicked
            });
            td.addEventListener('input', function () {
                updateCellColor(this);
            });
            row.appendChild(td);
        }
        tbody.appendChild(row);
    }
}

function updateCellValue(cell) {
    const valueInput = document.getElementById('valueInput');
    const newValue = valueInput.value.trim();
    if (newValue.length === 0) {
        cell.textContent = '0';
    } else {
        cell.textContent = newValue;
    }
    updateCellColor(cell); // Update color when value is set
}

function updateCellText() {
    const text = document.getElementById('cellText').value.trim();
    const cells = document.querySelectorAll('#myTable tbody td');

    if (text.length === 0) {
        text = "0";
    }

    cells.forEach(cell => {
        cell.textContent = text;
        updateCellColor(cell); // Update color when text is set
    });
}

function updateCellColor(cell) {
    let value = cell.textContent.trim();
    let color = '';

    if (value.length === 0) {
        value = "0";
        cell.textContent = value; // Set to "0" if empty
    }

    if (!isNaN(value) && value !== '') {
        const num = parseFloat(value);
        if (num < colours.length && num >= 0) {
            color = colours[num];
        }
    }

    cell.style.backgroundColor = color;
}

function exportTable() {
    const rows = document.querySelectorAll('#myTable tbody tr');
    const data = Array.from(rows).map(row => {
        const cells = row.querySelectorAll('td');
        return Array.from(cells).map(cell => cell.textContent.trim() || ''); // Convert to text and handle empty cells
    });

    // Format the array as a string in the form {{1,2,3,4,5},{1,2,3,4,5}}
    const formattedData = data.map(row => `{${row.join(',')}}`).join(',');

    // Wrap with curly braces
    const output = `{${formattedData}}`;

    // Display or copy the output
    console.log(output); // For debugging purposes
    alert(output); // Display in an alert box for easy copying
}

// Initialize table
document.addEventListener('DOMContentLoaded', () => {
    resizeTable();

    const valueInput = document.getElementById('valueInput'); // Ensure this references the correct input

    function updateInputColor() {
        const value = parseFloat(valueInput.value);
        let color = '';

        if (!isNaN(value) && value >= 0 && value < colours.length) {
            color = colours[value];
        }

        valueInput.style.backgroundColor = color;
    }

    // Initial color update
    updateInputColor();

    // Add event listener to update color on input change
    valueInput.addEventListener('input', updateInputColor);
});
