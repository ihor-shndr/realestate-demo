import Layout from "@/components/layout/Layout";
import Link from "next/link";
export async function getBooks() {
  // Call an external API endpoint to get posts
  const res = await fetch("https://pa3ksnnme2.us-east-1.awsapprunner.com/graphql/", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      query: `{
		books  (first:10){
		  nodes{
			title
			}
	  }
	  }`,
    }),
  });

  return JSON.parse(await res.text())["data"]["books"]["nodes"];
}
export default async function BlogGrid() {
  return (
    <>
      <Layout headerStyle={1} footerStyle={1} breadcrumbTitle="Blog">
        <section className="flat-section">
          <div className="container">
            <div className="row">
              {(await getBooks()).map((data, index) => (
                <div className="col-lg-4 col-md-6">
                  <Link
                    href="/blog-detail"
                    className="flat-blog-item hover-img"
                  >
                    <div className="img-style">
                      <img src="/images/blog/blog-1.jpg" alt="img-blog" />
                      <span className="date-post">January 28, 2024</span>
                    </div>
                    <div className="content-box">
                      <div className="post-author">
                        <span className="fw-7">Esther</span>
                        <span>Furniture</span>
                      </div>
                      <h6 className="title">
                        {data.title}
                      </h6>
                      <p className="description">
                        The average contract interest rate for 30-year
                        fixed-rate mortgages with conforming loan balances...
                      </p>
                    </div>
                  </Link>
                </div>
              ))}

              <div className="col-12 text-center">
                <Link href="#" className="tf-btn size-1 primary">
                  Load More
                </Link>
              </div>
            </div>
          </div>
        </section>
      </Layout>
    </>
  );
}
