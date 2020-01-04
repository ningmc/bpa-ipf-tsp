# This Makefile is for all IPF executables
#

IPFDIR = /shr/ipf-3.27

all:
	pwd
	cd $(IPFDIR)/ipf; pwd; ./build_libipf.bash
	cd $(IPFDIR)/ipc; pwd; ./build_libipc.bash
	cd $(IPFDIR)/gui; pwd; ./build_libgui.bash
	cd $(IPFDIR)/exe; pwd; make -f bpf.make; cp bpf /usr/bin
	cd $(IPFDIR)/exe; pwd; make -f ipfsrv.make; cp ipfsrv /usr/bin
	cd $(IPFDIR)/exe; pwd; make -f ipf_reports.make; cp ipf_reports /usr/bin
	cd $(IPFDIR)/exe; pwd; make -f cutting.make; cp cutting /usr/bin
	cd $(IPFDIR)/exe; pwd; make -f netdat.make; cp netdat /usr/bin
	cd $(IPFDIR)/exe; pwd; make -f ipfplot.make; cp ipfplot /usr/bin
	cd $(IPFDIR)/exe; pwd; make -f ipfbat.make; cp ipfbat /usr/bin
	cd $(IPFDIR)/exe; pwd; make -f puf.make; cp puf /usr/bin
	cd $(IPFDIR)/exe; pwd; make -f gui.make; cp gui /usr/bin
	cd $(IPFDIR)/cflow; pwd; make -f findout.make; cp findout /usr/bin
	cd $(IPFDIR)/cflow; pwd; make -f pvcurve.make; cp pvcurve /usr/bin
	cd $(IPFDIR)/cflow; pwd; make -f qvcurve.make; cp qvcurve /usr/bin
	cd $(IPFDIR)/cflow; pwd; make -f mimic.make; cp mimic /usr/bin
	cd $(IPFDIR)/cflow; pwd; make -f post_pvcurve.make; cp post_pvcurve /usr/bin

clean:
	cd $(IPFDIR)/ipf; pwd; rm -f *.o *.a
	cd $(IPFDIR)/ipc; pwd; rm -f *.o *.a
	cd $(IPFDIR)/gui; pwd; rm -f *.o *.a
	cd $(IPFDIR)/exe; pwd; rm -f *.o bpf
	cd $(IPFDIR)/exe; pwd; rm -f ipfsrv
	cd $(IPFDIR)/exe; pwd; rm -f ipf_reports
	cd $(IPFDIR)/exe; pwd; rm -f cutting
	cd $(IPFDIR)/exe; pwd; rm -f ipfbat
	cd $(IPFDIR)/exe; pwd; rm -f netdat
	cd $(IPFDIR)/exe; pwd; rm -f ipfplot
	cd $(IPFDIR)/exe; pwd; rm -f puf
	cd $(IPFDIR)/exe; pwd; rm -f gui gui.uid
	cd $(IPFDIR)/cflow; pwd; rm -f *.o findout pvcurve qvcurve mimic post_pvcurve
