As you may have guessed from the title, I chose to use `GitHub` as my provider of choice, seeing as it's a platform I use daily for both open source and professional work. No doubt similar to many others, ever since GitHub's acquisition by Microsoft in 2018 [^1], I've had lingering questions about user privacy and how my data is being used, especially considering I heavily rely on GitHub for both hobby projects and to advance my career, inadvertently placing a lot of trust I would rather avoid in a large mega corporation such as Microsoft.

# Recent perception of GitHub
Looking further into how my data is used by GitHub in particular and especially how it is passed to Microsoft feels particularly relevant currently seeing as the Zig Software Foundation (responsible for the programming language of the same name) have decided that now is the time to migrate hosting of their central source code repositories over to Codeberg[^2], for a variety of reasons, including:
- A $200,000 contract with ICE [^3]
- Extreme bit-rot typical of a Microsoft product massively degrading usability for the end user [^4]
- Pushing of artificial intelligence onto it's users [^5]

This, of course prompted a large wave of similar re-evaluations of GitHub reliance across the open source community at large, especially since GitHub logins are frequently used as an OIDC provider [^6], by association allowing Microsoft to track data given to them about the services logged in to in this manner.

Taking all of this into account, I felt now would be an opportune time to investigate just what data GitHub may have on me, which I'm sure is no doubt comprehensive considering my reliance on it as a product/service.
# Publicly available data 
When you start looking into how your data should be requested from GitHub[^7], the first thing they send you to is your public available profile page, which in my case looks like this:

![[GitHub profile.png]]

This is, of course, a page I am well aware of, having shared most of that data with the goal of being open and tying my identity to my open source work, and already reveals a lot of the data that GitHub has about me, including things like:
- The company I work for along with other organisations I'm a part of
- Precise activity day to day (presented in the green graph above)
- My name and approximate location

# Exporting my account
As described on their page for requesting an archive of the account data [^7], you may request a copy of all data GitHub has about you directly from your account settings page, which looks like:

![[Github account export.png]]

In order to be GDPR compliant you may also send an email to `dpo@github.com` in order to request this same data, however in my case the content of this email [^8] simply directed that I access the data in the very same manner, indicating that downloading this archive is likely a complete aggregation of the data GitHub is required to share about a user and that no alternative avenues exist in order to gain access to a more detailed/more complete repository of information about a user.
# What's inside
Downloading the account data returned me a `1.4GB` tarball [^9] containing all of the information GitHub shares about me.

![[Extracting tarball.png]]

After extracting the tarball I had a poke around to see what was inside. The first immediately noticeable thing I saw was that the source code for every single one of the repositories under my individual user's organization was included with the download, which was the clear majority of the download size:

![[Tarball contents.png]]
This is relatively unimportant from a privacy standpoint, so moving on the next most interesting thing was this `users_000001.json` file:

![[Users json.png]]

Which contained both my own user data and all public data about users I had frequently interacted with, which while it was interesting to read gave me no revelations about privacy. Similarly to this one were `pull_requests_00000<x>.json` files, which contain between them an entire list of every pull request I've ever submitted to the platform including both public and private repositories, `issues_00000<x>.json` which worked similarly for issues and a couple other less notable similar files.

Notable absent was any form of information pertaining to OIDC logins to external services that use GitHub as a provider, of which I have lost count of how many there should be. For example, one of these services which I use is Garnix [^10], who provide build resources I use frequently for building and testing my projects in an isolated environment and whom exclusively exist as an integration with GitHub, however, when I run a string search for "garnix" in the tarball archive I downloaded from GitHub, there is nothing related to logging in to or using Garnix:

![[Garnix Search.png]]

Which is something I found particularly surprising as GitHub absolutely keep this data around somewhere on a per user basis as evidenced by the entry on the `apps` page used for integrations with third party services like Garnix:

![[Third Party.png]]

Investigating this menu led me to discover that there was, in fact, a list of "Authorized OAuth Apps", very clearly indicating that the supposed "Total Export of Account Data" does not contain all of the data that GitHub has on me, which, even being obvious as an end user leads me to believe that they have vastly more data on me than they are letting on, perhaps stored somewhere separately.

# Conclusions
In conclusion, due to various concerns with GitHub, both as a platform/product and as a result of being owned by Microsoft, I had decided that now was as opportune of a time as any to investigate what data GitHub has on me, as unfortunately I have no choice but to rely on them both for open source contributions and for professional work.

In general the process for accessing my data was trivial, both avenues I attempted lead me back to the same tarball archive download, although the actual contents of said tarball appeared to lack data about me that GitHub very obviously has stored somewhere, leading me to extrapolate that the actual amount of data they store about me to be far more vast than just what they give out to end users.

[^1]: https://www.cnet.com/tech/tech-industry/microsoft-acquire-github-7-5-billion-stock-solidify-developer-ties/ - Accessed 19th December 2025

[^2]: https://ziglang.org/news/migrating-from-github-to-codeberg/ - Accessed 19th December 2025

[^3]: https://www.vox.com/recode/2019/10/9/20906605/github-ice-contract-immigration-ice-dan-friedman - Accessed 19th December 2025

[^4]: https://github.com/actions/runner/issues/3792 - Accessed 19th December 2025

[^5]: https://www.businessinsider.com/github-ceo-developers-embrace-ai-or-get-out-2025-8 - Accessed 19th December 2025
	

[^6]: https://docs.github.com/en/actions/how-tos/secure-your-work/security-harden-deployments/oidc-in-cloud-providers - Accessed 19th December 2025

[^7]: https://docs.github.com/en/get-started/archiving-your-github-personal-account-and-public-repositories/requesting-an-archive-of-your-personal-accounts-data - Accessed 19th December 2025

[^8]: ![[DPO Response]]

[^9]: https://en.wikipedia.org/wiki/Tar_(computing) - Accessed 19th Decemeber 2025

[^10]: https://garnix.io/ - Accessed 19th December 2025
