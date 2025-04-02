--The tripping Mercury
--The Tripper Mercury (manga)
function c100000303.initial_effect(c)
	--Pos Change
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SET_POSITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetValue(POS_FACEUP_ATTACK)
	e1:SetLabel(2)
	e1:SetCondition(c100000303.atkcon)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsFaceup))
	c:RegisterEffect(e1)
	local e4=e1:Clone()
	e4:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e4:SetTarget(aux.TargetBoolFunction(Card.IsFacedown))
	e4:SetValue(POS_FACEDOWN_ATTACK)
	c:RegisterEffect(e4)
	--summon with 3 tribute
	local e2=aux.AddNormalSummonProcedure(c,true,true,3,3,SUMMON_TYPE_TRIBUTE+1,aux.Stringc100000303(c100000303,0))
	--atk down
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_SET_ATTACK_FINAL)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e3:SetLabel(3)
	e3:SetCondition(c100000303.atkcon)
	e3:SetTarget(c100000303.atktg)
	e3:SetValue(0)
	c:RegisterEffect(e3)
end
function c100000303.ttcon(e,c,minc)
	if c==nil then return true end
	return minc<=3 and Duel.CheckTribute(c,3)
end
function c100000303.ttop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local g=Duel.SelectTribute(tp,c,3,3)
	c:SetMaterial(g)
	Duel.Release(g,REASON_SUMMON+REASON_MATERIAL)
end
function c100000303.atkcon(e)
	return e:GetHandler():GetMaterialCount()==e:GetLabel()
end
function c100000303.atktg(e,c)
	return c~=e:GetHandler()
end