--墓守の審神者
--Gravekeeper's Oracle
function c25524823.initial_effect(c)
	--summon with 3 tribute
	local e1=aux.AddNormalSummonProcedure(c,true,true,3,3,SUMMON_TYPE_TRIBUTE,aux.Stringc25524823(c25524823,0))
	--summon with 1 tribute
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc25524823(c25524823,1))
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_SUMMON_PROC)
	e2:SetCondition(c25524823.otcon)
	e2:SetTarget(c25524823.ottg)
	e2:SetOperation(c25524823.otop)
	e2:SetValue(SUMMON_TYPE_TRIBUTE)
	c:RegisterEffect(e2)
	--summon success
	local e3=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc25524823(c25524823,6))
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_SUMMON_SUCCESS)
	e3:SetCondition(c25524823.condition)
	e3:SetTarget(c25524823.target)
	e3:SetOperation(c25524823.operation)
	c:RegisterEffect(e3)
	--tribute check
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_MATERIAL_CHECK)
	e4:SetValue(c25524823.valcheck)
	c:RegisterEffect(e4)
	e3:SetLabelObject(e4)
	e4:SetLabelObject(e3)
end
c25524823.listed_series={0x2e}
function c25524823.otfilter(c,tp,relzone)
	return (c:IsControler(tp) or c:IsFaceup()) and c:IsSetCard(0x2e) and aux.IsZone(c,relzone,tp)
end
function c25524823.otcon(e,c,minc,zone,relzone,exeff)
	if c==nil then return true end
	if minc>1 or c:GetLevel()<=6 then return false end
	local tp=c:GetControler()
	local mg=Duel.GetMatchingGroup(c25524823.otfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,tp,relzone)
	return Duel.CheckTribute(c,1,1,mg,tp,zone)
end
function c25524823.ottg(e,tp,eg,ep,ev,re,r,rp,chk,c,minc,zone,relzone,exeff)
	local mg=Duel.GetMatchingGroup(c25524823.otfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,tp,relzone)
	local sg=Duel.SelectTribute(tp,c,1,1,mg,tp,zone,true)
	if sg and #sg>0 then
		sg:KeepAlive()
		e:SetLabelObject(sg)
		return true
	end
	return false
end
function c25524823.otop(e,tp,eg,ep,ev,re,r,rp,c)
	local sg=e:GetLabelObject()
	c:SetMaterial(sg)
	Duel.Release(sg,REASON_SUMMON+REASON_MATERIAL)
	sg:DeleteGroup()
end
function c25524823.valcheck(e,c)
	local g=c:GetMaterial()
	local ct=g:FilterCount(Card.IsSetCard,nil,0x2e)
	local lv=g:GetSum(Card.GetLevel)
	e:SetLabel(lv)
	e:GetLabelObject():SetLabel(ct)
end
function c25524823.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_TRIBUTE)
end
function c25524823.filter(c)
	return c:IsFacedown()
end
function c25524823.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=e:GetLabel()
	local b1=e:GetLabelObject():GetLabel()>0
	local b2=Duel.IsExistingMatchingCard(c25524823.filter,tp,0,LOCATION_MZONE,1,nil)
	local b3=Duel.IsExistingMatchingCard(Card.IsFaceup,tp,0,LOCATION_MZONE,1,nil)
	if chk==0 then return ct>0 and (b1 or b2 or b3) end
	local sel=0
	local off=0
	repeat
		local ops={}
		local opval={}
		off=1
		if b1 then
			ops[off]=aux.Stringc25524823(c25524823,2)
			opval[off-1]=1
			off=off+1
		end
		if b2 then
			ops[off]=aux.Stringc25524823(c25524823,3)
			opval[off-1]=2
			off=off+1
		end
		if b3 then
			ops[off]=aux.Stringc25524823(c25524823,4)
			opval[off-1]=3
			off=off+1
		end
		local op=Duel.SelectOption(tp,table.unpack(ops))
		if opval[op]==1 then
			sel=sel+1
			b1=false
		elseif opval[op]==2 then
			sel=sel+2
			b2=false
		else
			sel=sel+4
			b3=false
		end
		ct=ct-1
	until ct==0 or off<3 or not Duel.SelectYesNo(tp,aux.Stringc25524823(c25524823,5))
	e:SetLabel(sel)
	if (sel&2)~=0 then
		local g=Duel.GetMatchingGroup(c25524823.filter,tp,0,LOCATION_MZONE,nil)
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,#g,0,0)
	end
end
function c25524823.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local sel=e:GetLabel()
	if (sel&1)~=0 and c:IsFaceup() and c:IsRelateToEffect(e) then
		local lv=e:GetLabelObject():GetLabel()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(lv*100)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD_DISABLE)
		c:RegisterEffect(e1)
	end
	if (sel&2)~=0 then
		local g=Duel.GetMatchingGroup(c25524823.filter,tp,0,LOCATION_MZONE,nil)
		Duel.Destroy(g,REASON_EFFECT)
	end
	if (sel&4)~=0 then
		local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_MZONE,nil)
		local tc=g:GetFirst()
		for tc in aux.Next(g) do
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD)
			e1:SetValue(-2000)
			tc:RegisterEffect(e1)
			local e2=e1:Clone()
			e2:SetCode(EFFECT_UPDATE_DEFENSE)
			tc:RegisterEffect(e2)
		end
	end
end