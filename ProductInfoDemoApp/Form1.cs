using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;
using System.Configuration;

namespace ProductInfoDemoApp
{
    public partial class ProductInfoUI : Form
    {
        public ProductInfoUI()
        {
            InitializeComponent();
        }

        string connectionString = ConfigurationManager.ConnectionStrings["ProductDBConStr"].ConnectionString;
        private void saveButton_Click(object sender, EventArgs e)
        {
            if (IsTextBoxEmpty())
            {
                MessageBox.Show("Please enter the value.");
            }
            else 
            {
                if (productCodeTextBox.Text.Length < 3 || Convert.ToInt16(quantityTextBox.Text) <=0)
                {
                    MessageBox.Show("Product code must be atleast 3 character long and quantity should be an integer .");
                }
                else 
                {
                    if (IsProductCodeExists(productCodeTextBox.Text))
                    {
                        if (UpdateProduct() > 0)
                        {
                            MessageBox.Show("Product is updated successfully . ");
                            MakeTextBoxEmpty();
                        }
                        else
                        {
                            MessageBox.Show("Not updated .");
                        }
                    }
                   else 
                    {
                        if (SaveProduct() > 0)
                        {
                            MessageBox.Show("Saved .");
                            MakeTextBoxEmpty();
                        }
                        else 
                        {
                            MessageBox.Show("Product not saved . ");
                        }
                    }

                }
            }
        }

        private bool IsTextBoxEmpty()
        {
            bool isTextBoxEmpty = false;
            if (productCodeTextBox.Text =="" || descriptionTextBox.Text =="" || quantityTextBox.Text=="" )
            {
                isTextBoxEmpty = true;
            }
            return isTextBoxEmpty;
        }

        private bool IsProductCodeExists(string productCode) 
        {
            bool isProductCodeExist = false;
              using(SqlConnection sqlConnection = new SqlConnection(connectionString))
              {
                  SqlCommand cmd = new SqlCommand("Select ProductCode from tblProduct where ProductCode='"+productCode+"'",sqlConnection);
                  sqlConnection.Open();
                  SqlDataReader rdr =   cmd.ExecuteReader();
                  while (rdr.Read()) 
                  {
                      isProductCodeExist = true;
                  }
              }
              return isProductCodeExist;
        }

        private int UpdateProduct() 
        {
            int rowsAffected;
            using (SqlConnection sqlConnection = new SqlConnection(connectionString)) 
            {
                SqlCommand cmd = new SqlCommand("Update tblProduct set Quantity= Quantity + '"
                    + quantityTextBox.Text + "' where ProductCode ='"
                    +productCodeTextBox.Text+"'",sqlConnection);
                sqlConnection.Open();
              rowsAffected = cmd.ExecuteNonQuery();
            }
            return rowsAffected;
        }

        private int SaveProduct() 
        {
            int rowsAffected;
            //int quantity = int.Parse(quantityTextBox.Text);
            using (SqlConnection sqlConnection = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("Insert into tblProduct values('"+productCodeTextBox.Text+"','"
                                                                                 +descriptionTextBox.Text+"','"
                                                                                 + Convert.ToInt16(quantityTextBox.Text)+"')", sqlConnection);
                sqlConnection.Open();
                rowsAffected = cmd.ExecuteNonQuery();
            }
            return rowsAffected;
        }

        private void showButton_Click(object sender, EventArgs e)
        {
            productListView.Items.Clear();
            ShowAllProduct();
            totalQuantityTextBox.Text = TotalQuantity().ToString(); 
        }

        private void ShowAllProduct() 
        {
            using(SqlConnection sqlConnection = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("Select ProductCode , Name , Quantity from tblProduct", sqlConnection);
                sqlConnection.Open();
                
                SqlDataReader rdr = cmd.ExecuteReader();

                while (rdr.Read())
                {
                    ListViewItem listViewItem = new ListViewItem(rdr["ProductCode"].ToString());
                    listViewItem.SubItems.Add(rdr["Name"].ToString());
                    listViewItem.SubItems.Add(rdr["Quantity"].ToString());
                    productListView.Items.Add(listViewItem);

                }
            }
        }
        private int TotalQuantity() 
        {
            int totalQuantity = 0;
            using(SqlConnection sqlConnection = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("Select Sum(Quantity) from tblProduct ",sqlConnection);
                sqlConnection.Open();
                totalQuantity = (int)cmd.ExecuteScalar();
            }

            return totalQuantity;
        }

        private void MakeTextBoxEmpty() 
        {
            productCodeTextBox.Text = "";
            descriptionTextBox.Text = "";
            quantityTextBox.Text = "";
        }



    }

    
}
