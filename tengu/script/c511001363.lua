--CX 冀望皇バリアン (Anime)
--CXyz Barian Hope (Anime)
--Rescripted by Larry126
function c511001363.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,7,3,nil,nil,99)
	c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_XYZ_MATERIAL)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetRange(0xff&~LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetTarget(c511001363.xyztg)
	e1:SetValue(function(e,ec,rc,tp) return rc==e:GetHandler() end)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_XYZ_LEVEL)
	e2:SetValue(function(e,mc,rc) return rc==e:GetHandler() and 7,mc:GetLevel() or mc:GetLevel() end)
	c:RegisterEffect(e2)
	--atk
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetValue(function(e,ec) return ec:GetOverlayCount()*1000 end)
	c:RegisterEffect(e3)
	--copy
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(c511001363)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	c:RegisterEffect(e4)
	aux.GlobalCheck(s,function()
		--Copy
		local ge1=Effect.GlobalEffect()
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_ADJUST)
		ge1:SetCondition(c511001363.con)
		ge1:SetOperation(c511001363.op)
		Duel.RegisterEffect(ge1,0)
	end)
end
c511001363.listed_series={SET_NUMBER_C}
function c511001363.cfilter(c)
	return c:IsHasEffect(511002571) and c:GetFlagEffect(5110013630)==0
end
function c511001363.con(e)
	return Duel.IsExistingMatchingCard(c511001363.cfilter,0,LOCATION_ALL,LOCATION_ALL,1,nil)
end
function c511001363.op(e)
	local g=Duel.GetMatchingGroup(c511001363.cfilter,0,LOCATION_ALL,LOCATION_ALL,nil)
	for c in aux.Next(g) do
		local effs={c:GetCardEffect(511002571)}
		for _,eff in ipairs(effs) do
			local te=eff:GetLabelObject()
			if te:GetCode()&511001822==511001822 or te:GetLabel()==511001822 then te=te:GetLabelObject() end
			local resetflag,resetcount=te:GetReset()
			local rm,max,code,flag,hopt=te:GetCountLimit()
			local prop1,prop2=te:GetProperty()
			local e1=Effect.CreateEffect(c)
			if te:GetDescription() then
				e1:SetDescription(te:GetDescription())
			end
			e1:SetLabelObject(te)
			e1:SetType(EFFECT_TYPE_XMATERIAL+te:GetType()&(~EFFECT_TYPE_SINGLE))
			if te:GetCode()>0 then
				e1:SetCode(te:GetCode())
			end
			e1:SetProperty(prop1|EFFECT_FLAG_CARD_TARGET,prop2)
			e1:SetCondition(c511001363.copycon(c))
			e1:SetCost(c511001363.copycost(c))
			if max>0 then
				e1:SetCountLimit(max,{code,hopt},flag)
			end
			if te:GetTarget() then
				e1:SetTarget(te:GetTarget())
			end
			if te:GetOperation() then
				e1:SetOperation(te:GetOperation())
			end
			if resetflag>0 and resetcount>0 then
				e1:SetReset(resetflag,resetcount)
			elseif resetflag>0 then
				e1:SetReset(resetflag)
			end
			c:RegisterEffect(e1,true)
			c:RegisterFlagEffect(5110013630,resetflag,prop1,resetcount)
		end
	end
end
function c511001363.copycon(oc)
	return function(e,tp,eg,ep,ev,re,r,rp)
		local con=e:GetLabelObject():GetCondition()
		return e:GetHandler():IsHasEffect(c511001363) and Duel.IsTurnPlayer(tp)
			and oc:GetFlagEffect(c511001363)==0 and (not con or con(e,tp,eg,ep,ev,re,r,rp))
	end
end
function c511001363.copycost(oc)
	return function(e,tp,eg,ep,ev,re,r,rp,chk)
		local c=e:GetHandler()
		local a=c:CheckRemoveOverlayCard(tp,1,REASON_COST)
		local b=Duel.CheckLPCost(tp,400)
		if chk==0 then return a or b end
		Duel.Hint(HINT_CARD,0,oc:GetOriginalCode())
		Duel.SetTargetCard(oc)
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringc511001363(c511001363,0))
		local op=Duel.SelectEffect(tp,{a,aux.Stringc511001363(c511001363,1)},{b,aux.Stringc511001363(c511001363,2)})
		if op==1 then
			Duel.SendtoGrave(oc,REASON_COST)
		else
			Duel.PayLPCost(tp,400)
		end
		oc:RegisterFlagEffect(c511001363,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,0,1)
	end
end
function c511001363.xyztg(e,c)
	local no=c.aux.xyz_number
	return c:IsFaceup() and no and no>=101 and no<=107 and c:IsSetCard(SET_NUMBER_C)
end