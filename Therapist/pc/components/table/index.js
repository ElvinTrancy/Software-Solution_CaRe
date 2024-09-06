function createTable(columns, data) {
  const tableWrapper = document.createElement('div');
  tableWrapper.className = 'table-wrapper'; // Add the wrapper class for styling

  const table = document.createElement('table');
  table.className = 'table'; // Apply the table class

  // Create table header
  const thead = document.createElement('thead');
  thead.className = 'table-thead'; // Apply the thead class
  const headerRow = document.createElement('tr');
  columns.forEach(column => {
      const th = document.createElement('th');
      th.textContent = column.label;
      th.className = ''; // Class for sortable columns
      headerRow.appendChild(th);
  });
  thead.appendChild(headerRow);
  table.appendChild(thead);

  // Create table body
  const tbody = document.createElement('tbody');
  tbody.className = 'table-tbody'; // Apply the tbody class
  data.forEach(row => {
      const tr = document.createElement('tr');

      columns.forEach(column => {
          const td = document.createElement('td');
          td.className = 'table-cell'; // Apply cell styling class

          if (column.key === 'select') {
              const checkbox = document.createElement('input');
              checkbox.type = 'checkbox';
              td.appendChild(checkbox);
          } else if (column.key === 'status') {
              const statusDiv = document.createElement('span');
              statusDiv.className = 'badge';
              const badge = document.createElement("span");
              if (row.status == 'Online') {
                badge.className = 'status-success status-dot'
              } else {
                badge.className = 'status-error status-dot'
              }
              statusDiv.appendChild(badge);
              const tx = document.createElement('span');
              tx.className = 'status-text';
              tx.innerText = row.status;
              statusDiv.appendChild(tx);
              td.appendChild(statusDiv);
          } else if (column.key === 'operations') {
            const rowData = row[column.key];
            if (rowData) {
              for(var i = 0; i < rowData.length; i++)
              {
                const operation = document.createElement('span');
                operation.className = 'a-button';
                operation.textContent = rowData[i];
                td.appendChild(operation);
                if (i != rowData.length - 1){
                  const divider = document.createElement('div');
                  divider.className = 'divider divider-vertical';
                  td.appendChild(divider);
                }
              }
            }              
          } else if(column.key === 'photo') {
            const photo = document.createElement('img');
            photo.className = 'photo';
            photo.src = row[column.key]; // Replace with actual path or URL
            photo.alt = row[column.key];
            td.appendChild(photo);
          } else {
              td.textContent = row[column.key];
          }

          tr.appendChild(td);
      });

      tbody.appendChild(tr);
  });

  table.appendChild(tbody);
  tableWrapper.appendChild(table); // Append the table to the wrapper

  return tableWrapper; // Return the wrapper containing the table
}
