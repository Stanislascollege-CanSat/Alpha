import java.util.Map;
import java.lang.Runnable;

// ===== CLASS: View ===== //

public class View {
  private String name;
  private PVector lookPos;
  private PVector upPos;
  private PVector straightRotation;
  private Runnable showExecutable;

  public View(String n, float lx, float ly, float lz, float ux, float uy, float uz, float rx, float ry, float rz, Runnable exe){
    this.name = n;
    this.lookPos = new PVector(lx,ly,lz);
    this.upPos = new PVector(ux,uy,uz);
    this.straightRotation = new PVector(rx,ry,rz);
    this.showExecutable = exe;
  }

  public PVector getLookPos(){
    return this.lookPos;
  }

  public PVector getUpPos(){
    return this.upPos;
  }

  public void setShowExecutable(Runnable exe){
    this.showExecutable = exe;
  }

  public void show(){
    translate(this.lookPos.x, this.lookPos.y, this.lookPos.z);
    rotateX(this.straightRotation.x);
    rotateY(this.straightRotation.y);
    rotateZ(this.straightRotation.z);

    this.showExecutable.run();

    rotateX(-this.straightRotation.x);
    rotateY(-this.straightRotation.y);
    rotateZ(-this.straightRotation.z);
    translate(-this.lookPos.x, -this.lookPos.y, -this.lookPos.z);

  }
}
