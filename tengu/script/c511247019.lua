--異次元の古戦場－サルガッソ (Anime)
--Sargasso the D.D. Battlefield (Anime)
--fixed by MLD
function c511247019.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Register Special Summons of Xyz Monsters
	local e2a=Effect.CreateEffect(c)
	e2a:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2a:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2a:SetRange(LOCATION_FZONE)
	e2a:SetCondition(c511247019.regcon)
	e2a:SetOperation(c511247019.regop)
	c:RegisterEffect(e2a)
	--Inflict 500 damage (Xyz Monster is Special Summoned)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc511247019(c511247019,0))
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_CUSTOM+c511247019)
	e2:SetTarget(c511247019.spsummonxyzdamtg)
	e2:SetOperation(c511247019.spsummonxyzdamop)
	c:RegisterEffect(e2)
	--Inflict 500 damage (Player controls an Xyz monster during the End Phase)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_PHASE+PHASE_END)
	e3:SetRange(LOCATION_FZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c511247019.controlxyzdamcon)
	e3:SetOperation(c511247019.controlxyzdamop)
	c:RegisterEffect(e3)
end
function c511247019.regcon(e,tp,eg,ep,ev,re,r,rp)
	local d1=false
	local d2=false
	for tc in eg:Iter() do
		if tc:IsFaceup() and tc:IsMonster() and tc:IsType(TYPE_XYZ) then
			if tc:GetControler()==0 then d1=true
			else d2=true end
		end
	end
	local evt_p=PLAYER_NONE
	if d1 and d2 then evt_p=PLAYER_ALL
	elseif d1 then evt_p=0
	elseif d2 then evt_p=1 end
	e:SetLabel(evt_p)
	return evt_p~=PLAYER_NONE
end
function c511247019.regop(e,tp,eg,ep,ev,re,r,rp)
	Duel.RaiseSingleEvent(e:GetHandler(),EVENT_CUSTOM+c511247019,e,0,tp,e:GetLabel(),0)
end
function c511247019.spsummonxyzdamtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsRelateToEffect(e) end
	Duel.SetTargetParam(500)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,0,0,ep,500)
end
function c511247019.spsummonxyzdamop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local d=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
	if ep==PLAYER_ALL then
		if not Duel.IsPlayerAffectedByEffect(tp,37511832) then
			Duel.Damage(tp,d,REASON_EFFECT,true)
		end
		if not Duel.IsPlayerAffectedByEffect(1-tp,37511832) then
			Duel.Damage(1-tp,d,REASON_EFFECT,true)
		end
		Duel.RDComplete()
	else
		if not Duel.IsPlayerAffectedByEffect(ep,37511832) then
			Duel.Damage(ep,d,REASON_EFFECT,true)
		end
	end
end
function c511247019.controlxyzdamcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(aux.FaceupFilter(Card.IsType,TYPE_XYZ),Duel.GetTurnPlayer(),LOCATION_MZONE,0,1,nil)
end
function c511247019.controlxyzdamop(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetTurnPlayer()
	if not Duel.IsPlayerAffectedByEffect(p,37511832) then
		Duel.Hint(HINT_CARD,0,c511247019)
		Duel.Damage(p,500,REASON_EFFECT)
	end
end