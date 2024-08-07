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
            td.addEventListener('input', function () {
                updateCellColor(this);
            });
            row.appendChild(td);
        }
        tbody.appendChild(row);
    }
}

function updateCellText() {
    const text = document.getElementById('cellText').value;
    const cells = document.querySelectorAll('#myTable tbody td');

    cells.forEach(cell => {
        cell.textContent = text;
        updateCellColor(cell); // Update color when text is set
    });
}

function updateCellColor(cell) {
    const value = cell.textContent.trim();
    let color;

    if (!isNaN(value) && value !== '') {
        const num = parseFloat(value);
        // Simple color mapping based on number range
        if (num <= 10) {
            color = '#ff9999'; // Light red
        } else if (num <= 20) {
            color = '#ffff99'; // Light yellow
        } else if (num <= 30) {
            color = '#99ff99'; // Light green
        } else {
            color = '#99ccff'; // Light blue
        }
    } else {
        color = ''; // No color if not a number
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
});
