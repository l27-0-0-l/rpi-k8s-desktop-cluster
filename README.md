# rpi-k8s-desktop-cluster


Goal of this project is to setup, document, customize or write components that would make small home rpi cluster act as desktop

I have started with 1 rpi3b+ and 3 rpi4b (4gb ram).
I've used https://medium.com/nycdev/k8s-on-pi-9cc14843d43 to setup cluster.


Below are initial drawings:

Physical network layout for multiple domain (3xswitch in ring)
https://docs.google.com/drawings/d/1XI8nkcKa3x-YcSedER6-IKUlBa9Y5fa52OVJSirwfQk/edit?usp=sharing

storage layout - having multiple pods (within daemonset) act as targets, and one pod acting as initiator, creating raid targets and providing storage share
https://docs.google.com/drawings/d/1XXn57l4X9QwumDOLttvCGhqcktzC4zwETvv7kQrHgRw/edit?usp=sharing
storage alternative as iscsi might not be flexible solution as ceph
https://docs.google.com/drawings/d/1TSiAGWaNOVeTTIKaaHx8rq-IWBkQBVRvHw-_R69R2qk/edit

expected service layers - many on single drawing
https://docs.google.com/drawings/d/1kvcEVfH1zeM1cWgTxiEpEaI1fUz_su6O05IjGHCAz_0/edit?usp=sharing

power management - hardware project (probably arduino + eth + relay shield)
https://docs.google.com/drawings/d/1V3gBbgemZfL_gll-Gbh4ge6LJ9uGnUedN-kgccuC3VU/edit?usp=sharing

hdmi and audio - hdmi should have switch (hardware project, probably arduino + eth shield + hdmi switch) and analog mixer
there will be a need for detection of connected hdmi, and labeling node with active hdmi connection
for pulseaudio there are some sound sharing solutions that could be helpful
https://docs.google.com/drawings/d/1xN0cfwsOpq-x7y147crP51LZHoOkih-m13GIcx99OWI/edit?usp=sharing

keyboard and mouse - there are remote usb services, maybe cluster wide usb port service registry would be needed
can we have kbd as a service, ie virtual keyboard
https://docs.google.com/drawings/d/1RBUqpRJxPFQtpxEOyP0FwwYWH5gkMkWKZMEl5JztnfE/edit?usp=sharing

https://docs.google.com/drawings/d/12uTbsPlmJqacferoNhRcVzllYPBdHpW0kgCveP47JpU/edit?usp=sharing

X windows - direct tcp or xpra ?
is there a need for 'console pod' - X/video/audio/kbd ?
https://docs.google.com/drawings/d/1U2cdBkTbMWLFxoZTjdltxxMJNdGBr-sDb09HCYXnwOI/edit?usp=sharing

bash - how to have bash that can switch between nodes and still operate ?
is there a nide to kps (kubernetes ps) that would act like ps on all nodes ?
how to preserve history ? 


LOG:
working on building haproxy-ingress for arm
successfuly build quay.io/loopback/haproxy-ingress:release-0.8
