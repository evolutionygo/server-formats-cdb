--Gladiator Beast Tamer Editor (Anime)
function c511009304.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2N(c,true,true,c511009304.ffilter,2)
	Fusion.AddContactProc(c,c511009304.contactfilter,c511009304.contactop,c511009304.splimit)
	--Special Summon
	local e0=Effect.CreateEffect(c)
	e0:SetDescription(aux.Stringc511009304(35089369,0))
	e0:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e0:SetType(EFFECT_TYPE_IGNITION)
	e0:SetRange(LOCATION_MZONE)
	e0:SetCountLimit(1)
	e0:SetTarget(c511009304.esptg)
	e0:SetOperation(c511009304.espop)
	c:RegisterEffect(e0)
	--negate attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetOperation(c511009304.op)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc511009304(29612557,0))
	e2:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c511009304.descon)
	e2:SetTarget(c511009304.destg)
	e2:SetOperation(c511009304.desop)
	c:RegisterEffect(e2)
	--shuffle and summon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringc511009304(92373006,0))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e3:SetCondition(c511009304.spcon2)
	e3:SetCost(c511009304.spcost2)
	e3:SetTarget(c511009304.sptg2)
	e3:SetOperation(c511009304.spop2)
	c:RegisterEffect(e3)
	aux.GlobalCheck(s,function()
		s[0]=false
		s[1]=false
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_DAMAGE_STEP_END)
		ge1:SetOperation(c511009304.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetOperation(c511009304.clear)
		Duel.RegisterEffect(ge2,0)
	end)
end
c511009304.listed_series={0x19}
c511009304.material_setcode=0x19
function c511009304.ffilter(c,fc,sumtype,tp)
	return c:IsSetCard(0x19,fc,sumtype,tp) and c:GetLevel()>=5
end
function c511009304.splimit(e,se,sp,st)
	return e:GetHandler():GetLocation()~=LOCATION_EXTRA
end
function c511009304.contactfilter(tp)
	return Duel.GetMatchingGroup(function(c) return c:IsMonster() and c:IsAbleToDeckOrExtraAsCost() end,tp,LOCATION_ONFIELD,0,nil)
end
function c511009304.contactop(g,tp)
	local cg=g:Filter(Card.IsFacedown,nil)
	if #cg>0 then
		Duel.ConfirmCards(1-tp,cg)
	end
	Duel.SendtoDeck(g,nil,SEQ_DECKSHUFFLE,REASON_COST+REASON_MATERIAL)
end
function c511009304.espfilter(c,e,tp)
	return c:IsSetCard(0x19) and c:IsType(TYPE_FUSION) and Duel.GetLocationCountFromEx(tp,tp,nil,c)>0 and c:IsCanBeSpecialSummoned(e,124,tp,true,false)
end
function c511009304.esptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511009304.espfilter,tp,LOCATION_EXTRA,LOCATION_EXTRA,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c511009304.espop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511009304.espfilter,tp,LOCATION_EXTRA,LOCATION_EXTRA,1,1,nil,e,tp)
	if #g>0 then
		Duel.SpecialSummon(g,124,tp,g:GetFirst():GetControler(),true,false,POS_FACEUP_ATTACK)
	end
end
function c511009304.desconfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x19) 
end
function c511009304.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511009304.desconfilter,tp,LOCATION_MZONE,LOCATION_MZONE,2,nil)
end
function c511009304.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.TRUE,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,PLAYER_ALL,0)
end
function c511009304.desop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsExistingMatchingCard(c511009304.desconfilter,tp,LOCATION_MZONE,0,1,nil) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local g=Duel.SelectMatchingCard(tp,aux.TRUE,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
		local tc=g:GetFirst()
		if tc then
			Duel.HintSelection(g)
			local p=tc:GetControler()
			if Duel.Destroy(tc,REASON_EFFECT)>0 then
				Duel.Damage(p,tc:GetAttack(),REASON_EFFECT)
			end
		end
	end
	if Duel.IsExistingMatchingCard(c511009304.desconfilter,1-tp,LOCATION_MZONE,0,1,nil) and Duel.SelectYesNo(1-tp,aux.Stringc511009304(25847467,0)) then
		Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_DESTROY)
		local g=Duel.SelectMatchingCard(1-tp,aux.TRUE,1-tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
		local tc=g:GetFirst()
		if tc then
			Duel.HintSelection(g)
			local p=tc:GetControler()
			if Duel.Destroy(tc,REASON_EFFECT)>0 then
				Duel.Damage(p,tc:GetAttack(),REASON_EFFECT)
			end
		end
	end
end
function c511009304.op(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
end
function c511009304.spcon2(e,tp,eg,ep,ev,re,r,rp)
	return s[tp]
end
function c511009304.checkop(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if (a:IsSetCard(0x19)) or (d and d:IsSetCard(0x19)) then
		s[0]=true
		s[1]=true
	end
end
function c511009304.clear(e,tp,eg,ep,ev,re,r,rp)
	s[0]=false
	s[1]=false
end
function c511009304.cfilter(c,ft)
	return c:IsFaceup() and c:IsSetCard(0x19) and c:IsAbleToDeck() and (ft>0 or c:GetSequence()<5)
end
function c511009304.spcost2(e,tp,eg,ep,ev,re,r,rp,chk)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if chk==0 then return Duel.IsExistingMatchingCard(c511009304.cfilter,tp,LOCATION_MZONE,0,1,e:GetHandler(),ft) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,c511009304.cfilter,tp,LOCATION_MZONE,0,1,1,e:GetHandler(),ft)
	Duel.SendtoDeck(g,nil,SEQ_DECKSHUFFLE,REASON_COST)
end
function c511009304.spfilter2(c,e,tp)
	return c:IsSetCard(0x19) and c:IsCanBeSpecialSummoned(e,124,tp,false,false)
end
function c511009304.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c511009304.spfilter2,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c511009304.spop2(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511009304.spfilter2,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if #g>0 then
		local tc=g:GetFirst()
		if tc then
			Duel.SpecialSummon(tc,124,tp,tp,false,false,POS_FACEUP)
			tc:RegisterFlagEffect(tc:GetOriginalCode(),RESET_EVENT+RESETS_STANDARD_DISABLE,0,0)
		end
	end
end