Blackboard[^1] is learning management system that needs no introduction to any Trinity student or staff member - for a lot of us, it's the primary and even sole way to engage with our work, and extremely rarely is an alternative presented or even considered. It provides a single access point for students for almost everything they might need in their daily lives, including course work and assignments, study materials, or even the occasional online video call.

Starting from 2014[^2] Trinity has had ever growing usage of _Blackboard Learn_[^3], the digital platform for learning sold as a service by it's parent company, Anthology. This has culminated in Blackboard becoming a non optional part of student life as it is required for many day to day tasks. In that time, it has gained ever more access to data about students and their lives to a scale many may not realise, which is especially egregious considering there is no feasible way to avoid much of it.

# What does Blackboard track?
Blackboard track a vast amount of data from it's users[^5], including:
- **Marketing Information**: _Blackboard_ are able to figure out what students may be interested in and share that data with advertising vendors like _Google AdWords_ or _Facebook_[^5], which is extrapolated from things like a student's module and subject choices or maybe things they have mentioned in submissions which divulge personal data or interests.
- **Personalization Data**: _Blackboard_ allow logging in with multiple OpenID Connect (OIDC) providers, which is a standard protocol for determining who a user is based on an external service they have already logged into. Directly, this includes providers such as _Microsoft_, which are then able to explicitly link any user data _Blackboard_ may share with them to the logged in user.
- **Student Submissions**: _Blackboard_ retains the right to store and potentially share any student submissions[^5], such as "responses to quizzes", "files you submit" or "audio" or "video recordings", which may be surprising to many that these submissions can live as long as they do, being directly used for "Analytics and Recommendations", and shared to like _Amazon Web Services_ or _Google Analytics_[^5].

Additionally, the data from the Blackboard Student Timetable[^6] can trivially be used to predict the location of a student at any given moment during a school term, which presents an obvious and major security risk.

# How does Blackboard acquire data?
Blackboard acquires data in a number of different ways depending on how users interact with the platform. First and foremost, the learning management system makes frequent use of various cookie embeddings to track things from login sessions to general identification of who the user is. For the purpose of demonstration, the following were sourced from inspecting the network requests of our very own class page [^7]. For this experiment it should be noted I am using Librewolf[^8] with uBlock Origin[^12] on NixOS[^9], and your results may vary depending on device, browser and a number of other factors.

In total, a single force refjresh (`CONTROL` + `f5`) on most browsers for me caused a download of a grand total of **51** different JavaScript blobs, which is quite high. These can be broken down into a number of sections, including:
- Scripts required to run the blackboard single page application (the majority of the bundle), most of which have been minified with `webpack`[^10] for both code obfuscation and reduced network usage, making them hard to inspect.
- `cookie.js`[^11], the cookie implementation for Blackboard. From this we learn that if we inspect the value of `document.cookie`, we can see some of the cookie values that blackboard stores directly. In my case these were:

| Name                       | Value                  |
| -------------------------- | ---------------------- |
| `COOKIE_CONSENT_ACCEPTED`  | `true`                 |
| `BbClientCalenderTimeZone` | `Europe/Dublin`        |
| `JSESSIONID`               | Arbitrary hashed value |
| `AWSELB`                   | Arbitrary hashed value |
| `AWSELBCORS`               | Arbitrary hashed value |
- `pendo.js`[^13], a known tracking script from _Pendo_ used for marketing and user retention purposes, which was blocked automatically by my browser. _Pendo_, in their own words[^14], is a "product intelligence platform" which tracks every interaction with the product. _Blackboard_, being a single page application are using the _Pendo SPA Framework_[^20] , which gives a full stream of events identifiable on a per user basis, each of which is configurable by the consumer (_Blackboard_ in this case) [^21].
- `js-agent.newrelic.com`[^15], which is from another user tracking platform - _Newrelic_[^16] , which seems to focus more on "ads intelligence" and "logs". This runs off of a similar browser agent architecture to _Pendo_ [^22] . This seems to be a largely automatically setup browser tracking agent, and as such provides a large number of capabilities which may seem nice for a platform developer but may also be a privacy risk, the most egregious of which being Full Session Replay [^23], which allows for replaying up to 4 hours of a given user's exact activity and clicks on a page.

It should be remembered that, as extensive as it seems, this is just a subset of the tracking that can be found through normal methods. Blackboard also state that they collect _Content and Activity_, meaning things like chat logs or submitted materials. Unfortunately, there is no easy way to trace where these end up other than offhand mentions from blackboard of things like _Google AdWords_ or _Facebook Business_.

# What can you do about this?
While in a lot of cases, there is not much you can do about this tracking short of endlessly petitioning Trinity to switch to some form of open source tracking free alternative to Blackboard, there are steps you can take individually to avoid a lot of the tracking.

For example, your browser setup is crucial to blocking a lot of the tracking. Things like a hardened Firefox setup[^17] or Librewolf[^8] will block the vast majority of these tracking methods by default, making them good choices for any privacy minded individuals. These typically include options like:
- Automatic clearing of cookies on session exit[^18]
- Spoofed hardware details (i.e. Librewolf on some Linux distribution appears as firefox on windows, which is by far more common)[^19]
- Installation of an ad-blocker such as uBlock Origin[^12]
- Another good option may be the use of a tool like Adnauseum[^26], which goes one step further than an ad-blocker and implements more active obfuscation of your data by _actively clicking on advertisements_. However, because of the sheer quantity/throughput it can handle, this has an inverse effect to what advertisers are looking for, as if you appear "interested" in every single advertisement it becomes impossible to narrow down what they should actually show you to effectively advertise to you. In some cases, this may even actively waste advertisers money as, with enough people doing this, the turnover rate of advertising budget to product sold drops exponentially.

There are also a number of lesser settings on _Blackboard_ itself you may configure for enhanced privacy:
- Use the most minimal "x" can view my profile on the [^24] _Blackboard_ profile page
- Disable any extra applications you have granted authorisation tokens under the [^25] tools page, which manages _Blackboard_'s own OpenID Connect authentication scopes.
# Why take these steps to protect yourself
I am certain that the vast majority of students would feel at the very least, uncomfortable with what _Blackboard_ are able to to with their data, or the fact that it remains in their possession for as long as it does. Aside from the obvious and previously discussed ethical ramifications, this also poses a serious security risk in the event of any form of data breach on _Blackboard_'s behalf. For example, if the timetable data of some students were to be released, they could have their precise, predictable location leaked, which I believe many would be uncomfortable with someone acting in bad faith having access to.

Engagement and academic performance data can also evidently be used to predict a given student's future results and may be used to inform employment platforms, such as LinkedIn, about how good of a worker a student may make, which may unfairly reflect their character in an inaccurate way. Personally, I find the potential for academic profiling making it's way to third parties the worst out of _Blackboard_'s data harvesting policies.
# Conclusion
In conclusion, it should be clear by now that the tracking done by _Blackboard_ is incredibly invasive and extensive - and especially so considering that there is no feasible way to opt out of using it for a lot of people. As students, we have no choice but to trust that Blackboard are good people and don't expose our data to anyone malicious, however that becomes incredibly difficult when taking in to account even just the advertising providers that they do mention [^5]. It is nigh impossible to know what might be happening with our data behind the scenes, which presents a serious privacy risk as more and more of our college services are digitised.
jj
As a potential solution, I would like to implore Trinity to re-think it's use of _Blackboard_ as it's primary learning management system in the first place. On top of all the privacy issues raised above, the sheer size of the bundle sent for the web app, along with the generally subpar user experience and implementation of web standards, creates impossible to ignore red flags as someone who is into tech. While I can't find any official figures for how much Trinity spends on _Blackboard_ in a given year, one can only imagine it is a significant amount, and seeing as _Blackboard_ itself really is not that complex of a concept, I would recommend switching to some form of open source, self hosted alternative to ensure privacy and an excellent user experience for the users.

[^1]: https://www.anthology.com/ - Accessed 29th Oct 2025

[^2]: https://www.tcd.ie/news_events/articles/trinity-launches-new-online-courses/ - Accessed October 29th 2025

[^3]: https://gilfuseducationgroup.com/history-of-blackboard-and-the-blackboard-learning-system/ - Accessed October 29th 2025
	

[^4]: https://www.anthology.com/trust-center/cookie-statement - Accessed October 29th 2025

[^5]: https://www.anthology.com/trust-center/privacy-statement - Accessed October 29th 2025

[^6]: https://www.tcd.ie/itservices/vle/#accordion2170885 - Accessed 29th October 2025

[^7]: _What is the internet doing to me?_ Blackboard Page Network Requests filtered to JavaScript files - Accessed 5th November 2025 ![[Class Page Network Requests.png]]

[^8]: https://librewolf.net/ - Accessed 5th November 2025

[^9]: https://nixos.org/ - Accessed 5th November 2025

[^10]: https://webpack.js.org/ - Accessed 5th November 2025

[^11]: `cookie.js` file, which handle's blackboard's cookie implementation - Accessed 5th November 2025 ![[cookie.js]]

[^12]: https://ublockorigin.com/ - Accessed 5th November 2025

[^13]: Pendo.js - from [https://pendo.io](https://pendo.io) - Accessed 5th November 2025 ![[pendo.js src.png]]

[^14]: [https://www.pendo.io/about/](https://www.pendo.io/about/) - Accessed 5th November 2025

[^15]: `js-agent.newrelic.com` - Accessed 5th November 2025 ![[Newrelic request.png]]

[^16]: [https://newrelic.com/](https://newrelic.com/) - Accessed November 5th 2025

[^17]: https://brainfucksec.github.io/firefox-hardening-guide - Accessed November 5th 2025

[^18]: https://librewolf.net/docs/features/?pubDate=20250819#privacy - Accessed 5th November 2025

[^19]: https://seon.io/resources/3-examples-of-browser-spoofing-and-how-to-detect-them/ - Accessed 5th November 2025

[^20]: https://support.pendo.io/hc/en-us/articles/360031862272-Install-Pendo-on-a-single-page-web-application - Accessed 17th November 2025

[^21]: https://support.pendo.io/hc/en-us/articles/360032294291-Configure-Track-Events - Accessed 17th November 2025

[^22]: https://docs.newrelic.com/docs/browser/browser-monitoring/installation/install-browser-monitoring-agent/ - Accessed 17th November 2025

[^23]: https://docs.newrelic.com/docs/browser/browser-monitoring/browser-pro-features/session-replay/get-started/ - Accessed 17th November 2025

[^24]: https://tcd.blackboard.com/ultra/profile - Accessed 17th November 2025

[^25]: https://tcd.blackboard.com/ultra/tools - Accessed 17th November 2025

[^26]: https://adnauseam.io/
