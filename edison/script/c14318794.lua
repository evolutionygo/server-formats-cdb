--生命吸収装置
--Life Absorbing Machine
function c14318794.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_STANDBY_PHASE,0)
	c:RegisterEffect(e1)
	--recover
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc14318794(c14318794,0))
	e2:SetCategory(CATEGORY_RECOVER)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e2:SetCondition(c14318794.reccon)
	e2:SetTarget(c14318794.rectg)
	e2:SetOperation(c14318794.recop)
	c:RegisterEffect(e2)
	aux.GlobalCheck(s,function()
		s[0]={}
		s[1]={}
		s[2]={}
		s[3]={}
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_PAY_LPCOST)
		ge1:SetOperation(c14318794.checkop)
		Duel.RegisterEffect(ge1,0)
		aux.AddValuesReset(function()
			local p=Duel.GetTurnPlayer()
			s[p+2]={table.unpack(s[p])}
			s[p]={}
		end)
	end)
end
function c14318794.checkop(e,tp,eg,ep,ev,re,r,rp)
	if ep==Duel.GetTurnPlayer() then
		local val=math.ceil(ev/2)
		table.insert(s[ep],val)
	end
end
function c14318794.reccon(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer()
end
function c14318794.rectg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return #s[tp+2]>0 and (c:GetFlagEffect(c14318794)==0 or s[tp+2][c:GetFlagEffectLabel(c14318794)+1]) end
	local rec
	if c:GetFlagEffect(c14318794)==0 then
		rec=s[tp+2][1]
		c:RegisterFlagEffect(c14318794,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_STANDBY,0,1,1)
	else
		rec=s[tp+2][c:GetFlagEffectLabel(c14318794)+1]
		c:SetFlagEffectLabel(c14318794,c:GetFlagEffectLabel(c14318794)+1)
	end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(rec)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,rec)
end
function c14318794.recop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Recover(p,d,REASON_EFFECT)
end